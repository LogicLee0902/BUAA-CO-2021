# 数据指令分析

通过指令要求，一层层修改数据通路和结构

## R型 addu, subu：

IF：从 PC 寄存器取地址，根据地址从 IM 中获得指令编码，在下一周期存入 IF/ID 寄存器中

ID:IF/ID 寄存器取出指令，根据相应寄存器 rs、rt 地址获取其中数据，与 rd 地址一起在下一周期存入 ID/EX 寄存器

EX:从 ID/EX 寄存器获得上一阶段从 RF 中取得的值，经过 ALU 计算，下一周期将存入 EX/MEM 寄存器中，rd 地址继续流水。

MEM: rd 地址与 ALU 结果继续流水。

WB：MEM/WB 寄存器为 RF 提供 rd 地址与 WD，将相应数据写入 rd 中。

## I型：ori，lui

大致一致，区别在于ID和EX阶段的处理

ID:将指令低 16 位取出经过 EXT 存入 ID/EX 寄存器。

EX：ID/EX 提供 EXT 的结果，经过多路选择器提供给 ALU 的 B 端

## 内存访问指令：lw

访存时写入寄存器变为 rt，需要在 ID 级增加一个 MUX，同时，在 MEM 级需要 ALU 的输出来指定 DM 的地址获得数据，这个数据随着流水线传到 WB 阶段写入 RF，因此在 WB 需要增设一个 MUX（不同于A3的MUX，但我觉得应该直接选完A3然后存到ID级[可以合并的一个MUX]或者说再之后得到A3之后传回来））。

## 写入：sw

内存的写入在 MEM 级需要增加为 DM 提供的写入数据，并且在 WB 阶段没有实质性的数据通路，即无需写回到 RF

## 跳转B型：beq

注意在D级增加CMP单元，减少Stall的周期.beq 需要在取出 rs、rt 寄存器的值后进行比较，然后决定是否跳转到新的 PC 值，新的 PC 的值可以通过 ID 级有符号扩展后，左移两位，再与 PC+4 相加得到。

## 跳转J型指令：j、jal

无条件的可以在 ID 级就修改 PC 寄存器的值，但需要在 ID 级增加一个扩展 26 位立即数的部件，同时，jal 需要写入 ra 寄存器，PC+8 （会有一个nop）的值需要流水至 WB 级写入 RF

## 跳转R型：jr

R型跳转指令将 rs 写入 PC 寄存器，可以在 ID 级就修改 PC 寄存器，因此只需在 ID 级增加一个 MUX。

# 流水线冒险

## 结构冒险(Structural Hazard)

关键： **不同指令同时需要使用同一资源**

在普林斯顿结构中，存储器和数据存储器是同一存储器，在取指阶段和存储阶段都需要使用这个存储器，这时便产生了结构冒险。我们的实验采用哈佛体系结构，将指令存储器和数据存储器分开

还有一种在于同时对Reg进行读写（D级和W级），对于A3地址的覆盖。采用分离读写，（两个RF）,并将读写信号持续传递

## 控制冒险(Control Hazard)

**分支指令（如 beq ）的判断结果会影响接下来指令的执行流**的情况。在判断结果产生之前，我们无法预测分支是否会发生。然而，此时流水线还会继续取指，让后续指令进入流水线。

在 D 级读取寄存器后立即进行比较。（可以尽早产生结果可以缩短因不确定而带来的开销。）不论判断结果如何，我们都将执行分支或跳转指令的下一条指令。这也就是所谓的“**延迟槽**”。通过这种做法，我们可以利用编译调度，将适当的指令移入延迟槽中，充分利用流水线的性能。（注：**延迟槽中的指令不能为分支或跳转指令**，否则为未定义行为；**对于jal指令，应当向 31 号寄存器写入当前指令的 PC+8**。）

## 数据冒险(Data Hazard)

- Key Words
    
    转发与暂停
    
    需求者供给者
    
   ![math](https://latex.codecogs.com/svg.image?T_{max}&space;\&&space;T_{use})


    标记转发法
    

**需求者**：使用或传递寄存器的值的功能部件和流水线寄存器

如，对于 addu 指令，需要数据的是位于流水线 E 级的 ALU，对于 BEQ 指令，需要数据的是位于流水线 D 级的比较器 CMP。而对于 SW 指令，需要数据的有 EX 级的 ALU（这个数据用来计算存储地址），还有 MEM 级的 DM（这里需要存入的具体的值）。

**供给者**：所有的供给者，都是存储了上一级传来的各种数据**（保存reg新结果**）的流水级寄存器，而不是由 ALU 或者 DM 来提供数据。

假设当前需要的数据，其实已经计算出来，只是还没有进入寄存器堆，那么我们可以用**转发**( Forwarding )来解决，即不引用寄存器堆的值，而是直接从后面的流水级的供给者把计算结果发送到前面流水级的需求者来引用。如果我们需要的数据还没有算出来。则我们就只能**暂停**( Stall )，让流水线停止工作，等到我们需要的数据计算完毕，再开始下面的工作。

那么，如何判断所需的数据是否已经计算出来了呢？(即什么时候可以转发什么时候应该暂停，二者该怎么判定)

---

判定模型：**需求时间——供给时间模型**。

对于某一个指令的某一个数据需求，我们定义需求时间 $T_{use}$ 为：这条指令位于 D 级的时候，再经过多少个时钟周期就必须要使用相应的数据。

$T_{use}$的特点：1.静态值 2.同一条指令可以有两个不同值

例如，对于 beq 指令，立刻就要使用数据，所以 Tuse=0。

对于 addu 指令，等待下一个时钟周期它进入 EX 级才要使用数据，所以 $T_{use}$=1。

而对于 sw 指令，在 EX 级它需要 GPR[rs] 的数据来计算地址，在 MEM 级需要 GPR[rt] 来存入值，所以对于 rs 数据，它的 $T_{use_{rs}}$=1，对于 rt 数据，它的 $T_{use_{rt}}$=2。

在 P5 课下要求的指令集的条件下，Tuse 值有两个特点：

- 特点 1：是一个定值，每个指令的 $T_{use}$ 是一定的
- 特点 2：一个指令可以有两个 $T_{use}$ 值

---

对于某个指令的数据产出，我们定义供给时间 $T_{new}$ 为：位于E级及以后的某个指令，它经过多少个时钟周期可以算出结果并且存储到流水级寄存器里。

特点：1.动态值，随指令流动减少 2.一条指令可以有多个不同的值（和动态值相呼应）3.一个指令在一个阶段只有一个$T_{new}$

例如，对于 addu 指令，当它处于 EX 级，此时结果还没有存储到流水级寄存器里，所以此时它的 $T_{new}$=1，而当它处于 MEM 或者 WB 级，此时结果已经写入了流水级寄存器，所以此时 $T_{new}$=0。

在 P5 课下要求的指令集的条件下，Tnew 值有两个特点：

- 特点 1：是一个动态值，每个指令处于流水线不同阶段有不同的 Tnew 值
- 特点 2：一个指令在一个时刻只会有一个 Tnew 值（一个指令只有一个结果）

当两条指令发生数据冲突（前面指令的写入寄存器，等于后面指令的读取寄存器），我们就可以根据$T_{new}和T_{use}$值来判断策略。

1. $T_{new}$=0，说明结果已经算出，如果指令处于 WB 级，则可以通过寄存器的内部转发设计解决，不需要任何操作。如果指令不处于 WB 级，则可以通过转发结果来解决。
2. $T_{new}$<=$T_{use}$，说明需要的数据可以及时算出，可以通过转发结果来解决。
3. $T_{new}$>$T_{use}$，说明需要的数据不能及时算出，必须暂停流水线解决。

应为T_new是在E级后逐级递减的，因此需要对其在E级有一个输出化，之后每级-1

| 指令类别 | ⁍初值 |
| --- | --- |
| 运算类 | 1 |
| 读存储类 | 2 |
| 函数调用类 | 0 |

在不考虑暂停的条件下，我们可以利用转发机制处理所有冒险。在考虑暂停之后，将会对某些情况进行暂停，这些情况下将会停止取指，同时插入 nop 指令，此时无论是原始读出的数据还是转发过来的数据，都不会被使用

因此可以用$T_{new}$和$T_{use}$构造策略矩阵来进行判断

![image](https://user-images.githubusercontent.com/95061623/150623032-ede6d497-f894-4da1-a068-a00b35f77f44.png)

---

**转发标记法：**是在每个已经算出结果（存入寄存器的值）的流水级设置flag=1，这时候**允许**在当前流水级对应寄存器的值被转发到前面流水级。每到需要寄存器值的前面，就要**从前往后**依次判断哪一级流水线的该寄存器值可以被转发，如果都不能那就使用从GRF里读取的数据。这样做的合理性在于，一是暂停保证了在使用寄存器值的时候，必然已经算出结果；二是能通过这个优先级找到最近的修改该寄存器的操作，而不会错误地转发别的数值，比如：

`li $1,1
lw $1,-1($1)
addu $1,$1,$1
subu $11,$1,$0`

在subu转发的时候，会依次比较addu（是否已经flag=1，寄存器编号是否一样），lw（是否已经flag=1，寄存器编号是否一样）。这样保证了有多个转发点的时候选取最新的数据。

# AT法处理流水线数据冒险

A 指 Address，也就是**寄存器的地址**（编号）；T 指 Time，也就是前面所提到的 **Tuse 和 Tnew**。所谓 AT 法，就是指通过在 D 级对指令的 AT 信息进行译码并流水，就可以方便地构造出数据冒险的处理机制。

“译码并流水”：对于集中式译码，可以直接将译码信息流水；对于分布式译码，可以流水整个指令，并在需要时进行译码（看是指令驱动还是编码驱动）下文中的“译码并流水”均为此意。

## 转发（旁路）机制的构造

首先，我们**假设所有的数据冒险均可通过转发解决**。也就是说，当某一指令前进到必须使用某一寄存器的值的流水阶段时，这个寄存器的值一定已经产生，并**存储于后续某个流水线寄存器中**。

我们接下来分析需要转发的位点。当某一部件需要使用 GPR中的值时，如果此时这个值存在于后续某个流水线寄存器中，而还没来得及写入 GPR，我们就需要通过转发（旁路）机制将这个值从流水线寄存器中送到该部件的输入处。

根据我们对数据通路的分析，**这样的位点有**：

1. D 级比较器的两个输入（含 NPC 逻辑中寄存器值的输入）；
2. E 级 ALU 的两个输入；
3. M 级 DM 的输入。

为了实现转发机制，我们对这些输入前加上一个 MUX。这些 MUX 的默认输入来源是上一级中**已经转发过**的数据。

GPR 是一个特殊的部件，它既可以视为 D 级的一个部件，**也可以视为 W 级之后的流水线寄存器**。基于这一特性，我们将对 GPR采用**内部转发**机制。也就是说，当前 GPR 被写入的值会即时反馈到读取端上。

在对 GPR 采取内部转发机制后，这些 MUX 的其他输入来源就是这些 **MUX 之后所有流水线寄存器中对 GPR 写入的、且对当前 MUX 的默认输入不可见的数据**。具体来说，D 级 MUX 的其他输入来源是 D/E 和 E/M 级流水线寄存器中对 GPR 写入的数据。由于 M/W 级流水线寄存器中对 GPR 写入的数据可以通过 GPR 的内部转发机制而对 D 级 MUX 的默认输入可见，因此无需进行转发。对于其他流水级的转发 MUX，输入来源可以类比得出。

选择信号的生成规则是：只要**当前位点的读取寄存器地址和某转发输入来源的写入寄存器地址相等且不为 0**，（0号不用转发始终为0）就选择该转发输入来源；在有多个转发输入来源都满足条件时，**最新产生的数据优先级最高**。为了获取生成选择信号所需的信息，我们需要**对指令的读取寄存器和写入寄存器在 D 级进行译码并流水**（指令的“ A 信息”）。

## 暂停（阻塞）机制的构造

接下来，我们来处理通过转发不能处理的数据冒险。在这种情况下，新的数据还未来得及产生。我们只能暂停流水线，等待新的数据产生。为了方便处理，**所述暂停是指将指令暂停在 D 级**。

首先，我们来回顾一下 Tuse 和 Tnew 的定义：

- $T_{use}$：指令进入 **D 级**后，其后的某个功能部件**再**经过多少时钟周期就**必须**要使用寄存器值。对于有两个操作数的指令，其**每个操作数的 Tuse 值可能不等**（如 store 型指令 rs、rt 的 Tuse 分别为 1 和 2 ）。
- $T_{new}$：位于 **E 级及其后各级**的指令，再经过多少周期就能够产生要写入寄存器的结果。在我们目前的 CPU 中，W 级的指令Tnew 恒为 0；对于同一条指令，Tnew@M = max(Tnew@E - 1, 0)。

那么，我们什么时候需要在 D 级暂停呢？根据 Tuse 和 Tnew 所提供的信息，我们容易得出：**当 D 级指令读取寄存器的地址与 E 级或 M 级的指令写入寄存器的地址相等且不为 0，且 D 级指令的 Tuse 小于对应 E 级或 M 级指令的 Tnew 时**，我们就需要在 D 级暂停指令。在其他情况下，数据冒险均可通过转发机制解决。

为了获取暂停机制所需的信息，我们还需要**对指令的 Tuse 和 Tnew 信息在 D 级进行译码，并将 Tnew 信息流水**（指令的“ T 信息”）。

将指令暂停在 D 级时，我们需要进行如下操作：

- 冻结 PC 的值
- 冻结 F/D 级流水线寄存器的值
- 将 D/E 级流水线寄存器清零（这等价于插入了一个 nop 指令）

如此，我们就完成了暂停机制的构建。

---

# 实现过程

## 需要变更的模块

### PC

多了一个使能端（用于暂停）

### NPC

需要有一个PC值分裂成，PCF和PCD，因为默认循环的PC+4是在F级完成的，而beq，jal，jr都是在D级。因此按照流水线设计的思路，要将PC值传递

### GRF

为了满足内部转发机制，所以在取RD1和RD2时，要判断A1和A3会不会相等(还要判断此时**写使能信号**)，相等则代表内容已经更新

## 新增模块

### IFID

用于F级D级之间的流水线寄存器

需要有一个使能端和清零端，用于暂停（暂停时要把取出的指令赌在IFID之前，且把里面存储的情空）

传输的端口需要PC4D和InstrD，前者用于后面与beq进行选择，后者用于驱动GRF

### CMP

用于提早判断beq是否压迫跳转

### IDEX

这里的处理方法和黑书有出入，也是为了和P3、P4的一致性，因为P3、P4都在GRF前将A3和WD选了出来，因此直接将A3和WD流水就可以了

### EXMEM，MEWB

类似，没有啥新鲜的内容

### Stall

暂停表达式构造，利用$T_{use}$和$T_{new}$

$T_{use}$和$T_{new}$需要阶段的指令来构造

对于每个指令（若要用到寄存器），分析其$T_{use}$，同时对于每个会对寄存器造成修改的指令，分析其$T_{new}$

![image](https://user-images.githubusercontent.com/95061623/150623048-ad2c6d07-532f-4697-af2b-c573bec3aa80.png)

我们根据这个表就可以构造出每个指令对应的暂停条件

```verilog
//b_type
assign Stall_b = beq_D &&((Cal_r_E && (InstrE[rd]==InstrD[rs]||InstrE[rd]==InstrD[rt]))||(Cal_i_E && (InstrE[rt]==InstrD[rs]||InstrE[rt]==InstrD[rt]))||(Load_E && (InstrE[rt]==InstrD[rs]||InstrE[rt]==InstrD[rt]))||(Load_M && (InstrM[rt]==InstrD[rs]||InstrM[rt]==InstrD[rt])));
//calculate_r						
assign Stall_r = Cal_r_D &&((Load_E && (InstrE[rt]==InstrD[rs]||InstrE[rt]==InstrD[rt])));
//calculate_i						
assign Stall_i = Cal_i_D &&((Load_E && InstrE[rt]==InstrD[rs]));
//load						
assign Stall_l = Load_D &&((Load_E && InstrE[rt]==InstrD[rs]));
//store				
assign Stall_s = Store_D &&((Load_E && InstrE[rt]==InstrD[rs]));
//jr						
assign Stall_jr = jr_D &&((Cal_r_E && InstrE[rd]==InstrD[rs])||(Cal_i_E && InstrE[rt]==InstrD[rs])||(Load_E && InstrE[rt]==InstrD[rs])||(Load_M && InstrM[rt]==InstrD[rs]));
```

总共的暂停把这些或起来就好了

### Forward

标记转发法，注意每个阶段会对寄存器修改的指令是啥，对修改的地址与内容类型进行编码

采用标记转发法，即每一级中，对于会使GRF的产生变化的指令达标记

```verilog
assign FlagE = (InstrE[`op]==`JAL);
assign FlagM = (InstrM[`op]==`JAL)||(InstrM[`op]==`LUI)||(InstrM[`op]==`R&&InstrM[`func]==`ADDU)||(InstrM[`op]==`R&&InstrM[`func]==`SUBU)||(InstrM[`op]==`ORI);
assign FlagW = (InstrW[`op]==`JAL)||(InstrW[`op]==`LUI)||(InstrW[`op]==`R&&InstrW[`func]==`ADDU)||(InstrW[`op]==`R&&InstrW[`func]==`SUBU)||(InstrW[`op]==`ORI)||(InstrW[`op]==`LW);
```

同时需要为他们建立地址和数据来源的编码信息，方便转发

地址编码：

```verilog
assign addrE = (InstrE[`op]==`JAL) ? 5'd31 : 5'd0;
assign addrM = (InstrM[`op]==`JAL) ? 5'd31:
(InstrM[`op]==`LUI || InstrM[`op] == `ORI)?InstrM[`rt]:
(InstrM[`op]==`R && (InstrM[`func]==`ADDU || InstrM[`func]==`SUBU ))?InstrM[`rd]:5'd0;
```

数据选择编码：

```verilog
assign DataM= (InstrM[`op]==`JAL)?   2'd1:2'd0; //1 for PC+8, 0 for ALU Result
```

因为对GRF采用了内部转发的机制，所以无需对M/W级寄存器，而E级可以转发的只有JAL，因此特判以下就好了

内部转发机制：

```verilog
assign RD1 = (A1 == A3 && A1 != 0 && RegWrite)? WD:Reg[A1];
assign RD2 = (A2 == A3 && A2 != 0 && RegWrite)? WD:Reg[A2];
```

转发数据的确定：

```verilog
assign RD1 = (A1 == A3 && A1 != 0)? WD:Reg[A1];
assign RD2 = (A2 == A3 && A2 != 0)? WD:Reg[A2];
```

接下来分析需要转发的位点。当某一部件需要使用 GPR中的值时，如果此时这个值存在于后续某个流水线寄存器中，而还没来得及写入 GPR，我们就需要通过转发（旁路）机制将这个值从流水线寄存器中送到该部件的输入处。

根据我们对数据通路的分析，这样的位点有：

1. D 级比较器的两个输入（含 NPC 逻辑中寄存器值的输入）；
2. E 级 ALU 的两个输入；
3. M 级 DM 的输入。

对应的就有以下数据的选择

```verilog
//Forward for the CMP

assign RD1D = (InstrD[`rs]==0) ?0:
(InstrD[`rs]==FaddrE && FflagE)?FdataE:
(InstrD[`rs]==FaddrM && FflagM)?FdataM:
(InstrD[`rs]==A3W && FflagW)   ?WDW:
																RD1;

assign RD2D = (InstrD[`rt]==0) ?0:
(InstrD[`rt]==FaddrE && FflagE)?FdataE:
(InstrD[`rt]==FaddrM && FflagM)?FdataM:
(InstrD[`rt]==A3W && FflagW)   ?WDW:
																RD2;

//forward before the ALU
assign RD1BALUE = (InstrE[`rs]==0)?0:
		(InstrE[`rs]==FaddrM &&FflagM)?FdataM:
		(InstrE[`rs]==A3W && FflagW)  ?WDW:
																   RD1E;

assign RD2BALUE = (InstrE[`rt]==0)?0:
(InstrE[`rt]==FaddrM && FflagM)   ?FdataM:
(InstrE[`rt]==A3W && FflagW)      ?WDW:
                                   RD2E;

//forward before the DM

assign WDBDMM = (InstrM[`rt] == 0) ?0:
		(InstrM[`rt] == A3W && FflagW) ?WDW:
																		WDMemoryM;
```

# 注意事项

1. 转发是流水线寄存器的转发，而非模块组件的转发
2. 对于之后才传输的信号，在之前判定的时候是x的不定态，不好直接

# 第一次课上

挂了

课后没写清楚，func op写混了

课上图省事，Ctrl C+V，忘记把指令阶段数给替换，结果找的时候浪费了大段时间

加上课上测试的IM巨大，需要取[14:2]因为每过几个点导致心态崩了，在一些细微的点卡了好久

内部转发时也要判断下en信号

对于branch类指令，没有理解清空延迟槽是什么意思

**注意**： stall的时候不能清空（还未最终确定该不该清 ），因此判断应该是 `branch_flush && !Stall` 

## bnoall(?)

好像是这么个东西吧，就是如果GPR[rs]与GPR[rt]如果是相反数就跳转并连接，如果不是就清楚延迟槽

**注意**： stall的时候不能清空（还未最终确定该不该清 ），因此判断应该是 `branch_flush && !Stall` 

判断相反数也有坑，不能单纯判断两个数相加会不会等于0（相加之后溢出导致[31:0]均为0，比如两个`32'h8000_0000` 就是不是相反数），稳妥来看应该转换源码转补码判断

## ？？？（指令名忘了 ）

运算类 就是如果GPR[rt]为奇数，就将GPR[rs]循环左移GPR[rt]位，并存储到GPR[rd]；如果GPR[rt]为偶数，就将GPR[rs]循环右移GPR[rt]位，并存储到GPR[rd]

访存类没看了，或者说看了没记住

# 重构

为了使结构更加清晰一点，所以用了这几天来重构下，

重点在于将组件module依照阶段进行封装以及Stall的重写(真正的$T_{new}$与$T_{use}$)

## Stall

时间导向型

```verilog
		stall_rs0_e1 = Tuse_rs0 && (resOpE==`ALU) && (Instr[`rs]==A3E);
		stall_rs0_e2 = Tuse_rs0 && (resOpE==`DM) && (Instr[`rs]==A3E);
		stall_rs1_e2 = Tuse_rs1 && (resOpE==`DM) && (Instr[`rs]==A3E);
		stall_rs0_m1 = Tuse_rs0 && (resOpM==`DM) && (Instr[`rs]==A3M);
		stall_rs = stall_rs0_e1 || stall_rs0_e2 || stall_rs1_e2 || stall_rs0_m1;
		
		stall_rt0_e1 = Tuse_rt0 && (resOpE==`ALU) && (Instr[`rt]==A3E);
		stall_rt0_e2 = Tuse_rt0 && (resOpE==`DM) && (Instr[`rt]==A3E);
		stall_rt1_e2 = Tuse_rt1 && (resOpE==`DM) && (Instr[`rt]==A3E);
		stall_rt0_m1 = Tuse_rt0 && (resOpM==`DM) && (Instr[`rt]==A3M);
		stall_rt = stall_rt0_e1 || stall_rt0_e2 || stall_rt1_e2 || stall_rt0_m1;	
		
		stall = stall_rs||stall_rt;

//resop 相当于Tnew，但其并不是按照ppt中TTnew-=1，而是根据指令来进行assign
```

`Tuse` 与 `resOp`的创立

```verilog
			 Tuse_rs0=beq||jr;	//rs=0的指令
			 Tuse_rs1=addu||subu||ori||lui||sw||lw;	//rs=1的指令
			 Tuse_rt0=beq;
			 Tuse_rt1=addu||subu||lui;
			 Tuse_rt2=sw;
			 
			 resOpD=(addu||subu||ori||lui)?`ALU:			//指令的对应部件（等价于Tnew初始值）
					    (lw)			            ?`DM:
					    (jal)				          ?`PC:
					  					               `NW;
```


# 第二次课上

又挂啦

因为重构的代码DM开小了，导致一个点强测没过，然后不知道为啥,瞎找了大半天，然后用老代码发现过了那个点。课后经过讨论区提示才发现了。反复横跳着实浪费时间，一方面想着要不要de重构的bug，一方面又想着干脆用老代码好了。这次等同于我前两题各写了两遍，导致最后没有把最后一题调出来

## bltzal(差不多吧)

如果GPR[rs]小于0就跳转并连接，否则进入延迟槽

只记得这一个了， 运算类是有关溢出的，好像是不溢出就当正常加法，溢出要移位还是怎么的记不清了

访存类好像是奇偶然后结合半字咋样来着，记不住了

# 第三次课上

总算是过了，感觉题目难度已经降低很多了，要是第二次或者第一次是这个我说不定也能过（？）

## blezals

和上次挺像的，就是GPR[rs]≤0 就跳转，并且无条件link

## taddu

将GPR[rs]和GPR[rt]的补码相加存入GPR[rd]

## lrm

没有调出来

具体指令是根据base和imm算出Mem_addr, 取GPR[Mem_addr[4:0]]=GPR[rt]

感觉是我暂停没弄好（？）确实有点绕

😩
