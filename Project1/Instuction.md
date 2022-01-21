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
