#include<bits/stdc++.h>
using namespace std;
int main()
{
	
	while(1)
	{
		//system("D:\\Archive\\cpp\\BUAA_CO\\cmake-build-debug\\BUAA_CO.exe"); 
		//system("fc std.txt src.txt");
		system("D:\\Archive\\ISE\\Monocycle_CPU\\Monocycle_CPU.sim\\sim_1\\behav\\xsim\\BUAA_CO.exe"); 
		system("java -jar Mars.jar nc mc CompactDataAtZero dump .text HexText code.txt Test.asm 1> std.txt 2>err.txt");
		printf("Data have been already generated\n");
		system("Vivado -mode batch -source start.tcl"); 
		//system("open_project D:/Archive/ISE/Monocycle_CPU/Monocycle_CPU.xpr");
		system("cls");
		system("fc /W std.txt src.txt");
	//	system("pause");
		if(system("fc /W std.txt src.txt")) system("pause"); 
		system("cls");
 	} 
}

/*
打开mars的jar包之后我迅速找到了Mars.class，我在Idea上执行之后，发现它就是mars的主程序，然后里面创建了一个名为MarsLuanch的对象，在mars包下找到这个类后，看到了它有几百行的代码，简单测试之后，果然，发现他就是启动mars的类，然后我便在这里修改代码，创建一个output.txt并将系统输出重定向为此文件，之后的输出都将直接输出到这个文件中。在MarsLaunch的构造器中修改过的代码如下：

public MarsLaunch(String[] args) throws IOException{
         File file = new File("output.txt");  //创建文件
         if(!file.exists()){
               file.createNewFile();
            }
         PrintStream x = new PrintStream(file);
         System.setOut(x);
         boolean gui = (args.length == 0);
         Globals.initialize(gui);
}
比较难找的是RF和DM的部分，因为我本身对这个包不了解，很多命名方式不清楚，所以只能根据类的名字和它的方法不断摸索，最后在mars\mips\hardware路劲下找到了名为RegisterFile.class和Memory的两个类，我猜测这就是RF和DM的实现，在他们的几百行代码之中又分别发现了名为updateRegister和**setWord（取字）**的两个方法，根据名字判断，我猜测他们是写入的方法，然后根据代码，我在写如时插入代码测试，发现这两个方法确实是写入的方法，我修改了代码，将pc寄存器设置为public(原代码为private)，在写入时会输出相应的pc和地址，修改的代码如下
DM：

public int setWord(int address, int value) throws AddressErrorException {
         if (address % WORD_LENGTH_BYTES != 0) {
            throw new AddressErrorException(
               "store address not aligned on word boundary ",
               Exceptions.ADDRESS_EXCEPTION_STORE,address);
         }
         System.out.printf("@%08x: *%08x <= %08x\n", RegisterFile.programCounter.getValue() - 4 , address, value);//输出修改地址和值
         return (Globals.getSettings().getBackSteppingEnabled())
            ? Globals.program.getBackStepper().addMemoryRestoreWord(address,set(address, value, WORD_LENGTH_BYTES))
            : set(address, value, WORD_LENGTH_BYTES);
      }
RF：

for (int i=0; i< regFile.length; i++){
               if(regFile[i].getNumber()== num) {		//匹配寄存器
                   System.out.printf("@%08x: $%d <= %08x\n",programCounter.getValue() - 4, i, val);//输出修改的寄存器和值
                  old = (Globals.getSettings().getBackSteppingEnabled())
                        ? Globals.program.getBackStepper().addRegisterFileRestore(num,regFile[i].setValue(val))
                     	: regFile[i].setValue(val);
                  break;
               }
            }
至此修改工作全部完成，然后经过测试，重新打包为jar简单的测试版mars就完成了。
*/
