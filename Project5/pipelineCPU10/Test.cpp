#include<bits/stdc++.h> 
typedef long long ll;
using namespace std;
char a[10000],b[10010];
void delspace(char *a){
	int i,j=0;
	for(i=0;a[i];i++)
		if(a[i]!=' ')a[j++]=a[i];
	a[j]='\0';
}
int find(const char *a,const char s[]){
	return strstr(a,s)!=NULL;
}
int main(){
	FILE *cls=fopen("log.txt","w");
	ll t = 0;
	while(1)
	
	{
		system("D:\\Archive\\cpp\\BUAA_CO\\cmake-build-debug\\BUAA_CO.exe"); 
		system("java -jar Mars.jar nc db mc CompactDataAtZero dump .text HexText code.txt Test.asm>std.txt");
//		system("pause");
//	printf("Data have been already generated\n");
//	system("pause"); 
//	system("iverilog -o std ALU.v ADD4.v CMP.v A-T-Controller.v EXME.v EXT.v GRF.v IDEX.v IFID.v IM.v Forward-Controller.v MEWB.v mips.v MUX.v NPC.v StageE.v StageD.v StageF.v StageM.v STALL.v PC.v DM.v Controller.v tb.v");
//	system("vvp std");
//	system("pause");
	system("Vivado -mode batch -source start.tcl"); 
//	system("pause");
	int i;
	FILE *marsf1=fopen("std.txt","r");
	FILE *verif1=fopen("new.txt","r");
	FILE *marsF=fopen("marsResult2.txt","w");
	FILE *veriF=fopen("verilogOut2.txt","w");
	while(fgets(a,1000,marsf1)){
		delspace(a);
		if(!find(a,"$0")&&find(a,"@"))
			fprintf(marsF,"%s",a);
	}
//	system("pause");
	while(fgets(a,1000,verif1)){
		delspace(a);
		for(i=0;a[i];i++)if(a[i]=='@')break;
		//i+=5;//@0000xxxx
		i+=1;
		if(!find(a,"$0"))
			fprintf(veriF,"@%s",a+i);
	}
//	
//	system("pause");
	fclose(marsf1);
	fclose(verif1);
	fclose(veriF);
	fclose(marsF);
//	system("pause");
	FILE *marsF2=fopen("marsResult2.txt","r");
	FILE *veriF2=fopen("verilogOut2.txt","r");
//	system("pause");
	int cnt=0;
	FILE *log=fopen("log.txt","a");
	while(fgets(a,1000,marsF2)&&fgets(b,1000,veriF2)){
		cnt++;
//		cout << a <<"\n" <<b ;
//		cout << "-----\n";
	//	system("pause");
		while(a[strlen(a)-1]=='\n')a[strlen(a)-1]=0;
		while(b[strlen(b)-1]=='\n')b[strlen(b)-1]=0;
		if(strcmp(a,b))
		{
			fprintf(log,"wrong on line %d:output %s, expected %s.\n",cnt,b,a);
			fclose(log);
			printf("wrong!\n");
			system("pause");
		}
	}
	if(!cnt)
	{		fprintf(log,"None!");
			fclose(log);
			printf("wrong!\n");
			system("pause");
	}
//	system("puase");
	fclose(marsF2);
	fclose(veriF2);
	fprintf(log,"Epoch %d True.\n",++t);
//	system("pause");
	fclose(log);
}
	return 0;
}

