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
��mars��jar��֮����Ѹ���ҵ���Mars.class������Idea��ִ��֮�󣬷���������mars��������Ȼ�����洴����һ����ΪMarsLuanch�Ķ�����mars�����ҵ������󣬿��������м����еĴ��룬�򵥲���֮�󣬹�Ȼ����������������mars���࣬Ȼ���ұ��������޸Ĵ��룬����һ��output.txt����ϵͳ����ض���Ϊ���ļ���֮����������ֱ�����������ļ��С���MarsLaunch�Ĺ��������޸Ĺ��Ĵ������£�

public MarsLaunch(String[] args) throws IOException{
         File file = new File("output.txt");  //�����ļ�
         if(!file.exists()){
               file.createNewFile();
            }
         PrintStream x = new PrintStream(file);
         System.setOut(x);
         boolean gui = (args.length == 0);
         Globals.initialize(gui);
}
�Ƚ����ҵ���RF��DM�Ĳ��֣���Ϊ�ұ������������˽⣬�ܶ�������ʽ�����������ֻ�ܸ���������ֺ����ķ������������������mars\mips\hardware·�����ҵ�����ΪRegisterFile.class��Memory�������࣬�Ҳ²������RF��DM��ʵ�֣������ǵļ����д���֮���ֱַ�������ΪupdateRegister��**setWord��ȡ�֣�**���������������������жϣ��Ҳ²�������д��ķ�����Ȼ����ݴ��룬����д��ʱ���������ԣ���������������ȷʵ��д��ķ��������޸��˴��룬��pc�Ĵ�������Ϊpublic(ԭ����Ϊprivate)����д��ʱ�������Ӧ��pc�͵�ַ���޸ĵĴ�������
DM��

public int setWord(int address, int value) throws AddressErrorException {
         if (address % WORD_LENGTH_BYTES != 0) {
            throw new AddressErrorException(
               "store address not aligned on word boundary ",
               Exceptions.ADDRESS_EXCEPTION_STORE,address);
         }
         System.out.printf("@%08x: *%08x <= %08x\n", RegisterFile.programCounter.getValue() - 4 , address, value);//����޸ĵ�ַ��ֵ
         return (Globals.getSettings().getBackSteppingEnabled())
            ? Globals.program.getBackStepper().addMemoryRestoreWord(address,set(address, value, WORD_LENGTH_BYTES))
            : set(address, value, WORD_LENGTH_BYTES);
      }
RF��

for (int i=0; i< regFile.length; i++){
               if(regFile[i].getNumber()== num) {		//ƥ��Ĵ���
                   System.out.printf("@%08x: $%d <= %08x\n",programCounter.getValue() - 4, i, val);//����޸ĵļĴ�����ֵ
                  old = (Globals.getSettings().getBackSteppingEnabled())
                        ? Globals.program.getBackStepper().addRegisterFileRestore(num,regFile[i].setValue(val))
                     	: regFile[i].setValue(val);
                  break;
               }
            }
�����޸Ĺ���ȫ����ɣ�Ȼ�󾭹����ԣ����´��Ϊjar�򵥵Ĳ��԰�mars������ˡ�
*/
