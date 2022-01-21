# Verilog FSM 设计流程

- 描述状态机的最常用方法`always`和`case`

**注意事项**：

- 步骤展示
    1. 逻辑抽象，得出状态转移图
    2. 状态化简，将相同的状态进行合并（*optional*）
    3. 状态编码（one-hot, Gray,  Binary）在实际电路中，需综合考虑电路复杂度与电路性能之间的折中。这里的设计没有用到特别复杂的电路逻辑，所以可以自行决定用哪种编码方式。（不过，对于需要在FPGA上运行的电路，推荐使用独热编码方式。因为 FPGA 有丰富的寄存器资源，门逻辑相对缺乏，采用独热编码可以有效提高电路的速度和可靠性，也有利于提高器件资源的利用率。）
    
    > Gray: 相邻的二进制有且只有一个0/1不一样，卡诺图所采用的行列编码方式
    > 
    
    one-hot编码展示
    
    ```verilog
    parameter State1 = 4'b0001,
    					State2 = 4'b0010,
    					State3 = 4'b0100,
    					State4 = 4'b1000
    
    // or use define
    
    `define State1 4'b0001
     //不要加分号
    `define State2 4'b0010
    `define State3 4'b0100
    `define State4 4'b1000
    ```
    
    1. 根据状态转移图得出次态逻辑和输出逻辑
    2. 用verilog描述
        - 复位时回到起始状态（敏感信号为**时钟**和**复位**信号，注意同步复位和异步复位的区别）
        - 用 case 或 if-else 语句描述出状态的转移（根据现态（和输入）产生次态，可以与复位时回到起始状态的语句放在同一个 always 块中，即敏感信号为时钟和复位信号）
        - 输出信号描述。用 case 语句或 if-else 语句描述状态机的输出信号（or assign加上三目运算符）
        
    
    **注意事项**
    
    - case 语句的最后，要加上 **default** 分支语句，以避免锁存器的产生。
    - 状态机一般应设计为**同步**方式，并由一个时钟信号来触发。
    - 实用的状态机都应设计为由唯一的**时钟边沿**触发的**同步**运行方式。
    - 判断加有符号数的运算，不推荐三目，一般用always@(*)+case
    
    ```verilog
    always @(*) begin
          case(Aluop)
            4'd0:begin
                result = srca + srcb;
            end
            4'd1:begin
                result = srca - srcb;
            end
            4'd2:begin
                result = srca & srcb;
            end
            4'd3:begin
                result = srca | srcb;
            end
            4'd4:begin
                result = srca ^ srcb;
            end
            4'd5:begin
                result = srca > srcb;
            end
        endcase
      end
    ```
    
    ---
    

# 注意下 `$signed()`

`$signed()` 的真正功能是决定数据如何进行补位. 一个表达式 (特别注意**三目运算符**) 中如果存在一个无符号数, 那么整个表达式都会被当作无符号数.

- **self-determined expression**指一个 位宽可以由该表达式本身独立决定的expression。
- **context-determined expression**指一个位宽由其本身以及其所属的表达式共同决定的expression (例如一个阻塞赋值语句右侧表达式的位宽同时受左右两侧位宽的影响).
    
    

## **signedness**

Verilog 在计算表达式前, 会先计算表达式的 signedness. 计算方式如下:

- 仅由操作数决定，不由左侧决定 (如 `assign D = exp`，`exp` 符号与 `D` 无关. 这一点区别于位宽, 位宽由左右两侧所有表达式的最大位宽决定)
- 小数是有符号的, 显式声明了进制的数无符号, 除非用修饰符s声明了其有符号 (如 `'d12` 无符号，`'sd12` 有符号
- 位选/多位选择/位拼接的结果无符号 (如 `b[2]`, `b[3:4]`, `{b}` 均无符号)
- 比较表达式的结果无符号 (要么是 `0`, 要么是 `1`)
- 由实数强转成整型的表达式有符号
- 一个 self-determined expression 的符号性仅取决与其操作数
- 对于context-determined expression, 只有**所有操作数均为有符号数**时表达式才有符号

在计算表达式时, 先由以上规则得出最外层表达式的符号性, 再向表达式里的操作数递归传递符号性.

`$signed()` 函数的机制是计算传入的表达式, 返回一个与原表达式的值和位宽完全相同的值, 并将其**符号性设为有符号**. 该函数可以屏蔽外部表达式的符号性传递.

-------------
## 课下题解 P1_L1_BlockChecker

### 题目大意

本题为附加题，通过与否不计入P1课下通过条件。

现在需要你用Verilog语言编写一个模拟语句块检查的工具。

为了简化要求，**输入由ASCII字母和空格组成**。一个或多个连续出现的字母构成一个单词，单词**不区分大小写**，单词之间由一个或多个空格分隔开。检查工具检查**自复位之后的输入中**，begin和end是否能够匹配。

匹配规则类似括号匹配：一个begin只能匹配一个end，但是一个匹配的begin必须出现在对应的end之前；允许出现嵌套；最后若出现不能按上述规则匹配的begin或end，则匹配失败。

输入的读取在**时钟上升沿**进行。

匹配示例：Hello world begin comPuTer orGANization End

不匹配示例：eND beGin study


### 大题思路

对于输入的字符，利用状态转移方法判断其是否是begin or end

当检测到begin / end 时，对应的计数器++，并利用计数器来对result进行驱动，并判断是否匹配

<aside>
👀 即当cnt_begin == cnt_end时， result置1

当cnt_end > cnt_begin时，进入非法状态

</aside>

### 注意事项

本题注意点在于1）异步复位处理 2）关于误判的处理

针对 1），采用老方法

```verilog
always@(posedge clk, posedge reset)
begin

	if(reset == 1)
	begin
		// Go back to initial
	end
end 
```

针对2），综合来看，题目的意思是对于每个可能的点，都进行反应，如果发现不是，就复原，接触误会（*从endc end 可以看出来*）

由以上两点，不难得出状态图

### 状态图

![image](https://user-images.githubusercontent.com/95061623/150524897-11ffe05b-770c-415c-9d4a-508f3577e05f.png)


**注意**：

初始的状态应该是S1(即开始进入状态)，所以给status的赋值，与reset之后的还原都要弄回S1

### 错误经历

- 对于判断是否非法的处理（误判来讲），为例避免误判，应当我们确定输入了一个end时，再比较，而第一次写的时候，我已检测到cnt_end的变化就进行判断，针对虚晃一枪的情况就gg了
    
    **根本错误原因**， 对于状态转移的时机没有搞清楚
    

### Code

```verilog
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/10/22 19:41:49
// Design Name:
// Module Name: BlockChecker
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );

 parameter S0 = 4'b0000,
            S1 = 4'b0001,
            S2 = 4'b0010,
            S3 = 4'b0011,
            S4 = 4'b0100,
            S5 = 4'b0101,
            S6 = 4'b0110,
            S7 = 4'b0111,
            S8 = 4'b1000,
            S9 = 4'b1001,
            S10 = 4'b1010;

   reg [3:0] Status = S1;
   reg [31:0] Cnt_Begin = 0;
   reg [31:0] Cnt_End = 0;
   assign result = (Cnt_Begin == Cnt_End )? 1'b1 : 1'b0;
   always@(posedge clk, posedge reset)
   begin
    if(reset == 1)
    begin
        Status <= S1;
        Cnt_Begin <= 0;
        Cnt_End <= 0;
    end
    else
    begin
        case(Status)
            S0:
            begin
                if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S1:
            begin
                if(in == "b" || in == "B") Status <=S2;
                else if(in == "e" || in == "E") Status <= S7;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S2:
            begin
                if(in == "e" || in == "E") Status <= S3;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S3:
            begin
                if((in == "g") || (in == "G")) Status <= S4;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S4:
            begin
                if((in == "i") || (in == "I")) Status <= S5;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
           S5:
           begin
            if((in == "N") || (in == "n"))
            begin
                Cnt_Begin <= Cnt_Begin + 1;
                Status <= S6;
            end
            else if(in == " ") Status <= S1;
            else Status <= S0;
           end
           S6:
           begin
            if(in == " ") Status <= S1;
            else
            begin
                Cnt_Begin <= Cnt_Begin - 1;
                Status <= S0;
            end
           end
           S7:
           begin
            if(in == "n" || in == "N") Status <= S8;
            else if(in == " ") Status <= S1;
            else Status <= S0;
           end
           S8:
           begin
            if(in == "d" || in == "D")
            begin
                Cnt_End <= Cnt_End + 1;
                Status <= S9;
            end
            else if(in == " ")
            begin
                Status <= S1;
            end
            else Status <= S0;
           end
           S9:
           begin
            if(in == " ")
            begin
                 if((Cnt_Begin < Cnt_End)) Status <= S10;
                 else Status <= S1;
            end
            else
            begin
                Cnt_End <= Cnt_End - 1;
                Status <= S0;
            end
           end
           S10:
           begin
            Status <= S10;
           end
           default: Status <= S0;
        endcase
    end
   end
   /*
    always@(Cnt_Begin, Cnt_End)
    begin
        if((Cnt_Begin < Cnt_End) && Status == S1) Status <= S10;
    end*/
endmodule
```
