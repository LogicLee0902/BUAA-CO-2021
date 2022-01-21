#include<bits/stdc++.h> 
using namespace std;
int main()

{
	
	while(1)
	{
//	system("D:\\Archive\\cpp\\BUAA_CO\\cmake-build-debug\\BUAA_CO.exe"); 
//	printf("Over\n");
//	system("java -jar Mars.jar nc db mc CompactDataAtZero dump .text HexText code.txt Test.asm>sss.txt");
	printf("Done!\n");
//	system("pause");
//	printf("Data have been already generated\n");
//	system("pause"); 
//	system("iverilog -o std ALU.v ADD4.v CMP.v A-T-Controller.v EXME.v EXT.v GRF.v IDEX.v IFID.v IM.v Forward-Controller.v MEWB.v mips.v MUX.v NPC.v StageE.v StageD.v StageF.v StageM.v STALL.v PC.v DM.v Controller.v tb.v");
//	system("vvp std");
//	system("pause");
	system("Vivado -mode batch -source start.tcl"); 
	system("iverilog -o my.out myALU.v myCMP.v myController.v myDM.v myEXMEM.v myEXT.v myFORWARD.v myGRF.v myIDEX.v myIFID.v myIM.v myMEWB.v mymips.v myMUX.v myNPC.v myPC.v myStall.v mytb.v");
	system("vvp my.out");
//	system("iverilog -o .\\src_tb.out -I .\\src .\\src\\tb.v");
	
//	system("pause"); 
//	system("vvp src_tb.out > src_v.out");
	system("pause");
	if(system("fc new.txt src.txt")) system("pause");
//	system("pause");
	if(system("fc newd.txt srcm.txt")) system("pause");
//	system("pause"); 
	system("pause");
	}
	return 0;
		
}
