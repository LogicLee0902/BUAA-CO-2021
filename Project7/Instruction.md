## 任务

P7主要应该完成的事情

1. 更改流水线各级使其产生异常
2. 添加CP0处理异常
3. 用bridge与timer交互

## 概念补充

- 宏观 PC：虽然我们的 CPU 是流水线的，但是我们要将其封装模拟成一个单周期 CPU。而宏观 PC 就是这个单周期 CPU 的 PC 地址。我们要保证宏观 PC 前面的指令都已经完成了，后面的指令都没有执行过，当前的指令正在执行中。我们将 CP0 放在 M 级，因此也以 M 级为界线，规定 M 级的 PC 就是宏观 PC。
- 受害 PC：即哪条指令出了问题，我们要将这条出问题的指令存入 EPC。对于普通的异常，我们约定受害指令就是发生错误的那条指令。但是对于跳转指令，我们认为受害指令为跳转的目标指令。发生转问题时，我们流水线中的指令顺序为 D错误指令，E延迟槽，M跳转指令，此时根据上面的描述，受害 PC 是 D 级的 PC。对于 `j`、 `jr`、 `jal`、 `jalr` 指令，若跳转至不对齐的地址，则受害指令应当是 PC 值不正确的指令（即需要向 EPC 写入不对齐的地址）。

首先声明，在 P7，为了简单我们约定以下几件事：

1. 如果发生异常的指令是延迟槽指令，那么我们要求返回程序时仍然返回这条指令所属的跳转指令。也就是说“异常延迟槽回到跳转”。
2. 如果发生异常的指令是跳转指令，那么我们要求执行完延迟槽。详细解释见上述的“宏观 PC”。
3. 如果发生异常的指令是乘除指令的下一条，我们允许乘除指令不被撤回。也就是对于 `M错误指令，W乘除指令` 的情况，此时乘除槽正在计算，本来在异常处理时可能会覆盖乘除槽的结果，但是我们约定不会这么做。但是注意，如果是 `E乘除指令，M错误指令`，你要保证乘除指令不执行。

## CP0

CP0 要干的事就是接收到中断异常时看看是否允许其发生，允许的话记录一下状态方便 handler 处理。

我们要实现 CP0 中的四个寄存器：`SR`，`Cause`，`EPC`，`PrID`。

- SR 表示系统的状态，比如能不能发生异常
- Cause 记录异常的信息，比如是否处于延迟槽以及异常的原因
- EPC 记录发生异常的位置，便于处理完中断异常的时候返回
- PrID 是一个可以随便定义的寄存器，表示你的 CPU 型号

其中 `SR` 我们也只要实现一部分：`SR[15:10]` 表示允许发生的中断；`SR[1]` 表示是否处于中断异常中（是的话就不能发生中断异常）；`SR[0]` 表示是否允许中断。 `Cause` 也只要实现一部分：`Cause[31]` 表示延迟槽标记；`Cause[15:10]` 表示发生了哪个中断；`Cause[6:2]` 表示异常原因。 为了方便我们定义一些宏。

```verilog
`define IM SR[15:10]
`define EXL SR[1]
`define IE SR[0]
`define BD Cause[31]
`define hwint_pend Cause[15:10]
`define ExcCode Cause[6:2]
```

首先讲一下异常和中断的条件（按照 PPT 说的来）：

```verilog
wire IntReq = (|(HWInt & `IM)) & !`EXL & `IE; // 允许当前中断 且 不在中断异常中 且 允许中断发生
wire ExcReq = (|ExcCodeIn) & !`EXL; // 存在异常 且 不在中断中
assign Req  = IntReq | ExcReq;
```

发生异常的处理方法：

```verilog
if (Req) begin // int|exc
    `ExcCode <= IntReq ? 5'b0 : ExcCodeIn;
    `EXL <= 1'b1;
    EPCreg <= tempEPC;
    `BD <= bdIn;
end
```

这里讲一下 BD 是干啥的。如果异常发生在延迟槽，那么按照要求我们返回的时候要返回跳转指令。所以如果 BD 信号为真时应该输出上一条指令的 PC。

```verilog
wire [31:2] tempEPC = (Req) ? (bdIn ? PC[31:2]-1 : PC[31:2])
                            : EPCreg;
assign EPCout = {tempEPC, 2'b0};
```

然后就是记得每个时钟上升沿都要更新 `HWInt`：

```verilog
`hwint_pend <= HWInt;
```

退出异常的条件是识别到了 `eret`，我们直接把 `EXLClr` 接上 `M_eret` 就好。

# 具体实现

## 异常与中断

可理解为添加了两种新的跳转指令，

第一种跳转的条件是指令执行产生异常 or 外部外设发出了中断信号，跳转的位置是固定的 `0x4180` , 后续的处理和相应都是软件写好的，无需关心，跳转时要把受害PC写入EPC（关于各种情况的受害PC再之前已经讲述过了）

第二种跳转条件是遇到 `eret` 需要从当前地址跳回EPC中的地址，同时  **`eret` 后面的指令不能被执行** 

---

第一种情况需要使流水线可以产生异常（对于出现的异常的情况进行判断报错筛查），并在产生异常信号之后把其传递到M级的CP0，由CP0负责决定是否接受并处理这个异常，如果CP0觉得处理，就进行跳转

---

第二种需要在D级判断 `eret` 的处理（好像也有不少在M级再判断的（？）），出现就把FPC和NPC置于EPC和EPC+4 （置NPC是因为时钟沿的原因，如果不置的话，NPC算的应该是原先正常的PC应该得到的结果，因此需要把NPC也改了）

---

- 需要处理的异常类型
    
    
    | 异常与中断码 | 助记符与名称 | 指令与指令类型 | 描述 |
    | --- | --- | --- | --- |
    | 0 | Int (外部中断) | 所有指令 | 中断请求，来源于计时器与外部中断 |
    | 4 | AdEL (取指异常) | 所有指令 | PC 地址未字对齐 |
    | 4 | AdEL (取指异常) | 所有指令 | PC 地址超过 0x3000 ~ 0x6ffc |
    | 4 | AdEL (取指异常) | lw | 取数地址未与 4 字节对齐 |
    | 4 | AdEL (取指异常) | lh, lhu | 取数地址未与 2字节对齐 |
    | 4 | AdEL (取指异常) | lh, lhu , lb ,  lbu | 取 Timer 寄存器的值 |
    | 4 | AdEL (取指异常) | load | 计算地址时加法溢出 |
    | 4 | AdEL (取指异常) | load | 取数地址超出 DM、Timer0、Timer1 的范围 |
    | 4 | AdEL (取指异常) | load | 取数地址超出 DM、Timer0、Timer1 的范围 |
    | 5 | AdES (取指异常) | sw | 存数地址未 4 字节对齐 |
    | 5 | AdES (取指异常) | sh | 存数地址未 2 字节对齐 |
    | 5 | AdES (取指异常) | sh, sb  | 存 Timer 寄存器的值 |
    | 5 | AdES (取指异常) | store | 计算地址时加法溢出 |
    | 5 | AdES (取指异常) | store | 存数取址超出 DM、Timer0、Timer1 的范围 |
    | 10 | RI (未知指令) | - | 未知的指令码 |
    | 12 | Ov (溢出异常) | add, addi, sub | 算术溢出 |

有表格容易得出会抛出异常的地方有F级的IFU部分，D级的译码和E级的ALU部分与M级的DM

有关F级的异常与中断处理

则有关IFU的处理如下

```verilog
// ------ IFU ------
wire [31:0] tmp_F_PC;
F_PC _pc(
    .clk(clk),
    .reset(reset),
    .Req(Req),
    .PC_WrEn(PC_WrEn),
    .NPC(NPC),
    .PC(tmp_F_PC)
);
assign F_PC = D_eret ? EPC : tmp_F_PC;
assign F_EXC_AdEL = ((| F_PC[1:0]) | (F_PC < 32'h0000_3000) | (F_PC > 32'h0000_6ffc)) && !D_eret;
assign i_inst_addr = F_PC;
assign F_Instr = (F_EXC_AdEL) ? 32'd0 : i_inst_rdata;
// -----------------
```

有关F_EXC_AdeL是为了检测异常并发出信号，传入req(中断请求)是为了实现出现中断 PC 需要立刻变成 0x4180；此外，按照要求，如果出现异常，向后提交的 Instr 应当是 0（相当于一种阻塞），所以会有最后一句

关于D级的译码问题

```verilog
assign D_EXC_RI = !(beq | bne | bgez | bgtz | blez | bltz |
                    j | jal | jalr | jr |
                    lb | lbu | lh | lhu | lw | sb | sh | sw |
                    lui | addi | addiu | andi | ori | xori | slti | sltiu |
                    add | addu | sub | subu | And | Nor | Or | Xor | ori | slt | sltu |
                    sll | sllv | sra | srav | srl | srlv |
                    ((opcode == 6'b000000) && (funct==6'b000000)) |
                    div | divu | mfhi | mflo | mthi | mtlo | mult | multu |
                    mtc0 | mfc0 | eret);
```

对于ALU要判断地址有没有超和以及运算结果会不会溢出两种异常，所以因此需要传递下该计算的用途

```verilog

module E_ALU(
    input ALUDMOv,
    input ALUAriOv,
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output reg [31:0] C,
    output EXC_AriOv,
    output EXC_DMOv
);
```

其中ALUDMOv表示计算地址时溢出，ALUAriOV表示计算的溢出

判断是否溢出就是弄成33位，相加后看下最高位是否一致

```verilog
wire [32:0] ext_A = {A[31], A}, ext_B = {B[31], B};
    wire [32:0] ext_add = ext_A + ext_B;
    wire [32:0] ext_sub = ext_A - ext_B;
    assign EXC_AriOv = (ALUAriOv) && 
                       ((ALUOp == `ALU_add && ext_add[32] != ext_add[31]) ||
                       (ALUOp == `ALU_sub && ext_sub[32] != ext_sub[31]));
    assign EXC_DMOv = (ALUDMOv) && 
                       ((ALUOp == `ALU_add && ext_add[32] != ext_add[31]) ||
                       (ALUOp == `ALU_sub && ext_sub[32] != ext_sub[31]));
```

M级中要检测较多的东西，对应load和store的分别如下

- store
    
    ```verilog
    wire ErrAlign = ((BEOp == `BE_sw) && (|Addr[1:0])) ||
                        ((BEOp == `BE_sh) && (Addr[0]));
        
     wire ErrOutOfRange = !(((Addr >= `StartAddrDM) && (Addr <= `EndAddrDM)) ||
                               ((Addr >= `StartAddrTC1) && (Addr <= `EndAddrTC1)) ||
                               ((Addr >= `StartAddrTC2) && (Addr <= `EndAddrTC2)));
        
      wire ErrTimer = (Addr >= 32'h0000_7f08 && Addr <= 32'h0000_7f0b) ||
                        (Addr >= 32'h0000_7f18 && Addr <= 32'h0000_7f1b) ||
                        (BEOp != `BE_sw && Addr >= `StartAddrTC1);
     assign M_EXC_AdES = (store) && (ErrAlign || ErrOutOfRange || ErrTimer || M_EXC_DMOv);
    ```
    
- load
    
    ```verilog
    wire ErrAlign = ((DEOp == `DE_lw) && (|Addr[1:0])) ||
                        ((DEOp == `DE_lh || DEOp == `DE_lhu) && (Addr[0]));
        
        wire ErrOutOfRange = !(((Addr >= `StartAddrDM) && (Addr <= `EndAddrDM)) ||
                               ((Addr >= `StartAddrTC1) && (Addr <= `EndAddrTC1)) ||
                               ((Addr >= `StartAddrTC2) && (Addr <= `EndAddrTC2)));
        
        wire ErrTimer = (DEOp != `DE_lw) && (Addr >= `StartAddrTC1);
        assign M_EXC_AdEL = (load) && (ErrAlign || ErrOutOfRange || ErrTimer || M_EXC_DMOv);
    ```
    

本质上没啥差别

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ac8485d5-ccec-4a14-9c7a-f2a9397b5355/Untitled.png)

可以得到这张图

因为CP0是放在M级的，因此我们需要将异常传递至CP0所在的M级

**注意**：异常不能简单的流动，因为有可能前几级没有异常，而这一级新增了，所以每级的工作就是如果已经有异常了就传递，没有就看下这一级有没有新增

当一条指令出现多个异常时，应该传递出现的（指流水线的级数）

```verilog
// D 级    
assign D_EXCCode = tmp_D_EXCCode ? tmp_D_EXCCode :
                   D_EXC_RI ? `EXC_RI :
                   `EXC_None;
// E 级
assign E_EXCCode = (tmp_E_EXCCode) ? tmp_E_EXCCode :
                   (E_EXC_AriOv) ? `EXC_Ov :
                   `EXC_None;
// M 级
assign M_EXCCode = (tmp_M_EXCCode) ? tmp_M_EXCCode :
                   (M_EXC_AdES) ? `EXC_AdES :
                   (M_EXC_AdEL) ? `EXC_AdEL :
                   `EXC_None;
```

tmp_D_EXCode即为传递的异常编码，如果以及有了就传递，没有就覆盖

---

注意对于处于延迟槽中的指令，我们的 EPC 需要在 CP0 中特殊处理，因此当前指令是否在延迟槽内，我们需要新开一个信号 isInDelaySlot 跟着一起流水，

关于是否处于延迟槽可以通过下面的方法判断

```verilog
assign F_DelaySlot = (NPCOp != `NPC_pc4);
```

另外对于阻塞插入的 nop，PC 值和 isInDelaySlot 都不正确，因此我们需要在 DE 流水线寄存器中特殊处理

```verilog
if(flush || reset || Req || Stall) begin
    E_PC <= Stall ? D_PC : (Req ? 32'h0000_4180: 32'd0);
    E_Instr <= 32'd0;
    E_rs_data <= 32'd0;
    E_rt_data <= 32'd0;
    E_ext32 <= 32'd0;
    E_b_jump <= 0;
    E_DelaySlot <= Stall ? D_DelaySlot : 0;
    E_EXCCode <= 0;  
end
```

我们既然已经实现了异常的检测与传递，下面就是 P7 异常处理的核心 CP0 处理器，它负责接受前面传来的异常信号和外部传入的中断信号，然后综合分析决定是否响应这个异常

## CP0部分

| 端口 | 输入/输出 | 位宽 | 描述 |
| --- | --- | --- | --- |
| A1 | I | 5 | 指定 4 个寄存器中的一个，将其存储的数据读出到 RD |
| A2 | I | 5 | 指定 4 个寄存器中的一个，作为写入的目标寄存器 |
| Din | I | 32 | 写入寄存器的数据信号 |
| PC | I | 32 | 目前传入的下一个 EPC 值 |
| ExcCodeIn | I | 5 | 目前传入的下一个 ExcCode 值 |
| isInDelaySlot | I | 32 | 目前传入的下一个 BD 值 |
| HWInt | I | 6 | 外部硬件中断信号 |
| WE | I | 1 | 写使能信号，高电平有效 |
| EXLClr | I | 1 | 传入 eret 指令时将 SR 的 EXL 位置 0 ，高电平有效 |
| clk | I | 1 | 时钟信号 |
| reset | I | 1 | 同步复位信号 |
| Req | O | 1 | 输出当前的中断请求 |
| EPCOut | O | 32 | 输出当前 EPC 寄存器中的值 |
| Dout | O | 32 | 输出 A 指定的寄存器中的数据 |
| TestIntResponse | O | 1 | 检测CPU是否对外部中断产生响应，从而决定是否去写0x0000_7f20 |

功能定义：

| 序号 | 功能名称 | 功能描述 |
| --- | --- | --- |
| 1 | 同步复位 | 当时钟上升沿到来且同步复位信号有效时，将所有寄存器的值设置为0 |
| 2 | 读数据 | 读出 A1 地址对应寄存器中存储的数据到 RD；当 WE 有效时会将 WD 的值会实时反馈到对应的 RD，当 ERET 有效时会将 EXL 置 0，即内部转发。 |
| 3 | 写数据 | 当 WE 有效且时钟上升沿到来时，将 WD 的数据写入 A2 对应的寄存器中。 |
| 4 | 中断处理 | 根据各种传入信号和寄存器的值判断当前是否要进行中断，将结果输出到 IntReq。 |

内部主要干两件事，处理异常中断和管理那四个寄存器（我们只需要实现其中 4 个就行，注意还有两个是只读的，写入应该忽略）

管理寄存器就跟乘除槽管理 HI 和 LO 一样，开四个寄存器，然后根据 mfc0 和 mtc0 这两条指令处理他们的值就好

处理异常时需要干下面几件事

将**异常码 ExcCode**、**是否处于延迟槽中的判断信号 isInDelaySlot** 和  **当前 PC（如果取指地址异常则传递错误的 PC 值）** 一直跟着流水线到达 M 级直至提交至 CP0，由 CP0 综合判断分析是否响应该异常

如果需要响应该异常，则 CP0 **输出 Req 信号置为 1**，此时 FD、DE、DM、MW 寄存器响应 Req 信号，**清空 Instr，将 PC 值设为 0x4180**，然后**输入 F 级的 NPC 也被置为 0x4180**，**下一条指令从 0x4180 开始执行**

当外设和系统外部输入中断信号时，**CP0 同样也会确认是否响应该中断，然后把 Req 置为 1，执行相同的操作。异常中断同时发生则中断优先**！

当系统外部输入中断信号时，**CP0 还会输出一个 TestIntResponse 信号指示是否响应外部中断信号**，**如果响应则系统会相应去写 0x7f20 地址**，从而时外部中断信号停止

还有一件事是关于乘除槽的，如果有异常在乘除槽之前被检出，那么就不执行乘除法，简单来说就是**开启乘除槽条件在 Start 为 1 的基础上还要加一个 Req 为 0**

如果是 eret 指令，那么 EXL 需要置 0，表明当前处于用户态，并没有在处理异常（这时候可以响应别的异常了），对于 eret 指令，我们还需要修改 NPC，因为不管是跳到异常处理程序还是跳回去都需要改变 NPC 的值，具体的改变代码如下：

```verilog
assign NPC = (Req) ? 32'h0000_4180 :
                 (eret) ? EPC + 4:
                 (NPCOp == `NPC_pc4) ? F_PC + 4 :
                 (NPCOp == `NPC_jr_jalr) ? rs :
                 (NPCOp == `NPC_b && b_jump) ? D_PC + 4 + {{14{imm16[15]}}, imm16, 2'b00} :
                 (NPCOp == `NPC_j_jal) ? {D_PC[31:28], imm26, 2'b00} :
                 F_PC + 4;
```

对于新加的两条处理 CP0 寄存器的指令，不加任何转发，只是做了阻塞

只需要在 stall_control 里面加一句话就行：

```verilog
wire stall_eret = (D_eret) && ((E_mtc0 && E_rd_addr == 5'd14) || (M_mtc0 && M_rd_addr == 5'd14))
```

## Bidge

系统桥是处理 CPU 与外设（两个计时器）之间信息交互的通道

CPU 中 store 类指令需要储存的数据经过 BE 处理后会通过 `m_data_addr`, `m_data_byteen`, `m_data_wdata` 三个信号输出到桥中，桥会根据写使能 `m_data_byteen` 和地址 `m_data_addr` 来判断到底写的是内存还是外设，然后给出正确的写使能

load 类指令则是全部把地址传递给每个外设和 DM 中，然后桥根据地址选择从应该反馈给 CPU 从哪里读出来的数据，然后 DE 在处理读出的数据，反馈正确的结果

Bridge 的端口列表如下：

```verilog
module Bridge(
	output [31:0] m_data_addr,
	output [31:0] m_data_wdata,
	output [31:0] m_daata_byteen,
	input [31:0] m_data_rdata,

	input [31:0] tmp_m_data_addr,
	input [31:0] tmp_m_data_wdata,
	input [31:0] tmp_m_daata_byteen,
	output [31:0] tmp_m_data_rdata,

	output [31:0] TC0_Addr,
	output [31:0] TC0_WE,
	output [31:0] TC0_Din,
	input [31:0] Tc0_Dount,
	
	output [31:0] TC1_Addr,
	output [31:0] TC1_WE,
	output [31:0] TC1_Din,
	input [31:0] Tc1_Dount

)
```

直接根据地址选择是读内存还是外设，是传给 CPU 外设读出来的数据还是内存的数据

CPU 仅仅与 Bridge 交互，输出地址、输出数据、输入的数据全部进入 Bridge 里面，然后 Bridge 会根据地址判断到底是往哪里写，又反馈给 CPU 什么数据

**不用担心越界的问题，这次的 DM 和 Timer 都是助教给的**

## 顶层MIPS微体系

最后 mips.v 中实例化 CPU，Bridge，TC0 和 TC1 三个模块相互交互
利用这样两句实现写 0x7f20，停止中断使能（2021 新增）

```verilog
assign m_data_addr = (TestIntResponse && interrupt) ? 32'h0000_7f20 : bridge_m_data_addr;
assign m_data_byteen = (TestIntResponse && interrupt) ? 1 : bridge_m_data_byteen;
```

# P7 上机

EPC不用对齐！！！

## 新增指令: TEQ

当GPR[rs] == GPR[rt]时，异常，异常值为13

在D级判断，也要记得清空Instr

## 第二次上机

新增指令syscalls

就是呼唤一个异常，当作RI异常就好了
