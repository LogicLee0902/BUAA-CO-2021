# 搭建过程

把集中译码改成分布译码了，确实信号的流水需要加端口，而分布译码多实例化几个寄存器就好了， 同时集中译码会导致有时需要的编码要在W级才会得到（前面都是 `xxx`）而可能之前就已经调用，这时应该注意应该用 `===` (单纯的 `==` 会导致对于任何 `z` or `x` 都会置1 )

吴佬说的就是对的！

## 乘除

本质上和ALU差别不大，但需要注意有关乘除周期的实现（当初debug了有一阵时间）。我采用的方法是用计数器。初始和复位后，乘法为5，除法为0，每个上升沿进行操作更新。以乘法为例，当计数器为0，则说明计算结果完成，busy置为0， 如果计数器不等于5且不等于0，那么则随着时钟上升沿-1，busy置为1，如果读取到了乘除指令，开始运算，且此使要将Cnt-1（与verilog事件队列和上升沿更新的机制有关）

对于开始运算来说，如果直接32位直接开始运算似乎因为ISE的本身原因会有不知名的错误，除法容易想到使用 `/` and `%` 乘法的话使用拼接运算符， `{HI, LO} = D1 * D2` 

同时注意符号运算的处理，  `$signed` 也不能一股脑的加, 见下例

```verilog
{HI, LO} = $signed(D1) * $signed(D2); //Correct!
{HI, LO} = $signed( $signed(D1) * $signed(D2)); //Wrong!
```

第二种错的原因在于 最外层的sign屏蔽了位数信息，导致了总共只有32位，自然HI就都为0了。

# 易错
一般到后期会有大佬总结P5P6各个题型的，熟练掌握就可

复习前面易错的

关于课上测试看它

[P5P6分享](https://www.notion.so/P5P6-5a1750c75ee740b8ad6169ab03ff3245)

`signed`也不能加太多，会把位数信息给弄没

当高位没信息时，考虑考虑是不是位数信息无了

# 课上

难得一遍过

## bgezalc_new

改的花里胡哨 

```
I:
	Condition ← GPR[rs] ≥ 0
	GPR[rd] ← PC+8

I+1:
	if Condition then
	PC ← GPR[rt]
	endif
```

我的做法是还是将其归为branch类，然后NPC的特判下是不是它，再给NPC传一个MFCMP2D就好了

（有点像bgez和jalr的结合）

## clz

是在英文MIPS里面的

```
temp ← 32
for i in 31 .. 0
if GPR[rs]i = 1 then
temp ← 31 - i
break
endif
endfor
GPR[rd] ← temp
```

没啥，注意verilog应该是没有break的，所以需要达标记，把它归到cal_r类就好了

## lhs

条件储存lh

当地址为偶数，则取对应的半字符号扩展并储存到GPR[rt]

```
Addr ← sign_extend(offset) + base 
Byte ← Addr[1:0]
Addr_New = {Addr[31:2], 2'b0}
memword ← LoadMemory[Addr_New]
if Byte == 0
	GPR[rt] ← sign_extend(memword[15:0])
if Byte == 2
	GPR[rt] ← sign_extend(memword[31:16])
```
