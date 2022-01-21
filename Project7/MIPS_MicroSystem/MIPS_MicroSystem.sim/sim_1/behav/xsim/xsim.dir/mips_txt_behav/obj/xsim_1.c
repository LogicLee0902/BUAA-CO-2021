/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_84(char*, char *);
extern void execute_85(char*, char *);
extern void execute_86(char*, char *);
extern void execute_87(char*, char *);
extern void execute_88(char*, char *);
extern void execute_89(char*, char *);
extern void execute_90(char*, char *);
extern void execute_91(char*, char *);
extern void execute_2327(char*, char *);
extern void execute_2328(char*, char *);
extern void execute_2329(char*, char *);
extern void execute_2330(char*, char *);
extern void execute_2331(char*, char *);
extern void execute_2332(char*, char *);
extern void execute_96(char*, char *);
extern void execute_2306(char*, char *);
extern void execute_2307(char*, char *);
extern void execute_97(char*, char *);
extern void execute_200(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_202(char*, char *);
extern void execute_203(char*, char *);
extern void execute_204(char*, char *);
extern void execute_208(char*, char *);
extern void execute_603(char*, char *);
extern void execute_1002(char*, char *);
extern void execute_1004(char*, char *);
extern void execute_1303(char*, char *);
extern void execute_1304(char*, char *);
extern void execute_2272(char*, char *);
extern void execute_2273(char*, char *);
extern void execute_2274(char*, char *);
extern void execute_2275(char*, char *);
extern void execute_2276(char*, char *);
extern void execute_2277(char*, char *);
extern void execute_2278(char*, char *);
extern void execute_2279(char*, char *);
extern void execute_2280(char*, char *);
extern void execute_2281(char*, char *);
extern void execute_2282(char*, char *);
extern void execute_2283(char*, char *);
extern void execute_2284(char*, char *);
extern void execute_2285(char*, char *);
extern void execute_2286(char*, char *);
extern void execute_2287(char*, char *);
extern void execute_2288(char*, char *);
extern void execute_2289(char*, char *);
extern void execute_2290(char*, char *);
extern void execute_2291(char*, char *);
extern void execute_2292(char*, char *);
extern void execute_2293(char*, char *);
extern void execute_2294(char*, char *);
extern void execute_2295(char*, char *);
extern void execute_2296(char*, char *);
extern void execute_2297(char*, char *);
extern void execute_2298(char*, char *);
extern void execute_2299(char*, char *);
extern void execute_2300(char*, char *);
extern void execute_2301(char*, char *);
extern void execute_2302(char*, char *);
extern void execute_2303(char*, char *);
extern void execute_2304(char*, char *);
extern void execute_2305(char*, char *);
extern void execute_194(char*, char *);
extern void execute_196(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_199(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_101(char*, char *);
extern void execute_102(char*, char *);
extern void execute_103(char*, char *);
extern void execute_104(char*, char *);
extern void execute_105(char*, char *);
extern void execute_106(char*, char *);
extern void execute_107(char*, char *);
extern void execute_108(char*, char *);
extern void execute_109(char*, char *);
extern void execute_110(char*, char *);
extern void execute_111(char*, char *);
extern void execute_112(char*, char *);
extern void execute_113(char*, char *);
extern void execute_114(char*, char *);
extern void execute_115(char*, char *);
extern void execute_116(char*, char *);
extern void execute_117(char*, char *);
extern void execute_118(char*, char *);
extern void execute_119(char*, char *);
extern void execute_120(char*, char *);
extern void execute_121(char*, char *);
extern void execute_122(char*, char *);
extern void execute_123(char*, char *);
extern void execute_124(char*, char *);
extern void execute_125(char*, char *);
extern void execute_126(char*, char *);
extern void execute_127(char*, char *);
extern void execute_128(char*, char *);
extern void execute_129(char*, char *);
extern void execute_130(char*, char *);
extern void execute_131(char*, char *);
extern void execute_132(char*, char *);
extern void execute_133(char*, char *);
extern void execute_134(char*, char *);
extern void execute_135(char*, char *);
extern void execute_136(char*, char *);
extern void execute_137(char*, char *);
extern void execute_138(char*, char *);
extern void execute_139(char*, char *);
extern void execute_140(char*, char *);
extern void execute_141(char*, char *);
extern void execute_142(char*, char *);
extern void execute_143(char*, char *);
extern void execute_144(char*, char *);
extern void execute_145(char*, char *);
extern void execute_146(char*, char *);
extern void execute_147(char*, char *);
extern void execute_148(char*, char *);
extern void execute_149(char*, char *);
extern void execute_150(char*, char *);
extern void execute_151(char*, char *);
extern void execute_152(char*, char *);
extern void execute_153(char*, char *);
extern void execute_154(char*, char *);
extern void execute_155(char*, char *);
extern void execute_156(char*, char *);
extern void execute_157(char*, char *);
extern void execute_158(char*, char *);
extern void execute_159(char*, char *);
extern void execute_160(char*, char *);
extern void execute_161(char*, char *);
extern void execute_162(char*, char *);
extern void execute_163(char*, char *);
extern void execute_164(char*, char *);
extern void execute_165(char*, char *);
extern void execute_166(char*, char *);
extern void execute_167(char*, char *);
extern void execute_168(char*, char *);
extern void execute_169(char*, char *);
extern void execute_170(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_173(char*, char *);
extern void execute_174(char*, char *);
extern void execute_175(char*, char *);
extern void execute_176(char*, char *);
extern void execute_177(char*, char *);
extern void execute_178(char*, char *);
extern void execute_179(char*, char *);
extern void execute_180(char*, char *);
extern void execute_181(char*, char *);
extern void execute_182(char*, char *);
extern void execute_183(char*, char *);
extern void execute_184(char*, char *);
extern void execute_185(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void execute_192(char*, char *);
extern void execute_193(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_195(char*, char *);
extern void execute_12(char*, char *);
extern void execute_597(char*, char *);
extern void execute_598(char*, char *);
extern void execute_599(char*, char *);
extern void execute_600(char*, char *);
extern void execute_601(char*, char *);
extern void execute_602(char*, char *);
extern void execute_17(char*, char *);
extern void execute_399(char*, char *);
extern void execute_19(char*, char *);
extern void execute_20(char*, char *);
extern void execute_400(char*, char *);
extern void execute_401(char*, char *);
extern void execute_402(char*, char *);
extern void execute_23(char*, char *);
extern void execute_403(char*, char *);
extern void execute_499(char*, char *);
extern void execute_596(char*, char *);
extern void execute_29(char*, char *);
extern void execute_797(char*, char *);
extern void execute_996(char*, char *);
extern void execute_997(char*, char *);
extern void execute_998(char*, char *);
extern void execute_999(char*, char *);
extern void execute_1000(char*, char *);
extern void execute_1001(char*, char *);
extern void execute_796(char*, char *);
extern void execute_39(char*, char *);
extern void execute_894(char*, char *);
extern void execute_895(char*, char *);
extern void execute_896(char*, char *);
extern void execute_897(char*, char *);
extern void execute_898(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_45(char*, char *);
extern void execute_1299(char*, char *);
extern void execute_1300(char*, char *);
extern void execute_1301(char*, char *);
extern void execute_1302(char*, char *);
extern void execute_1100(char*, char *);
extern void execute_51(char*, char *);
extern void execute_1196(char*, char *);
extern void execute_1197(char*, char *);
extern void execute_1198(char*, char *);
extern void execute_1199(char*, char *);
extern void execute_54(char*, char *);
extern void execute_55(char*, char *);
extern void execute_1295(char*, char *);
extern void execute_1296(char*, char *);
extern void execute_1297(char*, char *);
extern void execute_1298(char*, char *);
extern void execute_58(char*, char *);
extern void execute_59(char*, char *);
extern void execute_1401(char*, char *);
extern void execute_1402(char*, char *);
extern void execute_1403(char*, char *);
extern void execute_1404(char*, char *);
extern void execute_1405(char*, char *);
extern void execute_1406(char*, char *);
extern void execute_1407(char*, char *);
extern void execute_61(char*, char *);
extern void execute_1504(char*, char *);
extern void execute_1980(char*, char *);
extern void execute_1981(char*, char *);
extern void execute_1982(char*, char *);
extern void execute_1983(char*, char *);
extern void execute_1984(char*, char *);
extern void execute_75(char*, char *);
extern void execute_2175(char*, char *);
extern void execute_2271(char*, char *);
extern void execute_77(char*, char *);
extern void execute_78(char*, char *);
extern void execute_2314(char*, char *);
extern void execute_2315(char*, char *);
extern void execute_2316(char*, char *);
extern void execute_2317(char*, char *);
extern void execute_2318(char*, char *);
extern void execute_2319(char*, char *);
extern void execute_2320(char*, char *);
extern void execute_81(char*, char *);
extern void execute_2321(char*, char *);
extern void execute_2322(char*, char *);
extern void execute_2323(char*, char *);
extern void execute_93(char*, char *);
extern void execute_94(char*, char *);
extern void execute_95(char*, char *);
extern void execute_2333(char*, char *);
extern void execute_2334(char*, char *);
extern void execute_2335(char*, char *);
extern void execute_2336(char*, char *);
extern void execute_2337(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_248(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_253(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_342(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_347(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_440(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_444(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_538(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_543(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_646(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_651(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_737(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_742(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_834(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_838(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_933(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_938(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1044(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1048(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1145(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1150(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1239(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1244(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1340(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1345(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1446(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1450(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1537(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1542(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1625(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1630(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1715(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1720(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1804(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1809(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1893(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1898(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2001(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2006(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2093(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2098(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2185(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2190(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[301] = {(funcp)execute_84, (funcp)execute_85, (funcp)execute_86, (funcp)execute_87, (funcp)execute_88, (funcp)execute_89, (funcp)execute_90, (funcp)execute_91, (funcp)execute_2327, (funcp)execute_2328, (funcp)execute_2329, (funcp)execute_2330, (funcp)execute_2331, (funcp)execute_2332, (funcp)execute_96, (funcp)execute_2306, (funcp)execute_2307, (funcp)execute_97, (funcp)execute_200, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_208, (funcp)execute_603, (funcp)execute_1002, (funcp)execute_1004, (funcp)execute_1303, (funcp)execute_1304, (funcp)execute_2272, (funcp)execute_2273, (funcp)execute_2274, (funcp)execute_2275, (funcp)execute_2276, (funcp)execute_2277, (funcp)execute_2278, (funcp)execute_2279, (funcp)execute_2280, (funcp)execute_2281, (funcp)execute_2282, (funcp)execute_2283, (funcp)execute_2284, (funcp)execute_2285, (funcp)execute_2286, (funcp)execute_2287, (funcp)execute_2288, (funcp)execute_2289, (funcp)execute_2290, (funcp)execute_2291, (funcp)execute_2292, (funcp)execute_2293, (funcp)execute_2294, (funcp)execute_2295, (funcp)execute_2296, (funcp)execute_2297, (funcp)execute_2298, (funcp)execute_2299, (funcp)execute_2300, (funcp)execute_2301, (funcp)execute_2302, (funcp)execute_2303, (funcp)execute_2304, (funcp)execute_2305, (funcp)execute_194, (funcp)execute_196, (funcp)execute_197, (funcp)execute_198, (funcp)execute_199, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)execute_107, (funcp)execute_108, (funcp)execute_109, (funcp)execute_110, (funcp)execute_111, (funcp)execute_112, (funcp)execute_113, (funcp)execute_114, (funcp)execute_115, (funcp)execute_116, (funcp)execute_117, (funcp)execute_118, (funcp)execute_119, (funcp)execute_120, (funcp)execute_121, (funcp)execute_122, (funcp)execute_123, (funcp)execute_124, (funcp)execute_125, (funcp)execute_126, (funcp)execute_127, (funcp)execute_128, (funcp)execute_129, (funcp)execute_130, (funcp)execute_131, (funcp)execute_132, (funcp)execute_133, (funcp)execute_134, (funcp)execute_135, (funcp)execute_136, (funcp)execute_137, (funcp)execute_138, (funcp)execute_139, (funcp)execute_140, (funcp)execute_141, (funcp)execute_142, (funcp)execute_143, (funcp)execute_144, (funcp)execute_145, (funcp)execute_146, (funcp)execute_147, (funcp)execute_148, (funcp)execute_149, (funcp)execute_150, (funcp)execute_151, (funcp)execute_152, (funcp)execute_153, (funcp)execute_154, (funcp)execute_155, (funcp)execute_156, (funcp)execute_157, (funcp)execute_158, (funcp)execute_159, (funcp)execute_160, (funcp)execute_161, (funcp)execute_162, (funcp)execute_163, (funcp)execute_164, (funcp)execute_165, (funcp)execute_166, (funcp)execute_167, (funcp)execute_168, (funcp)execute_169, (funcp)execute_170, (funcp)execute_171, (funcp)execute_172, (funcp)execute_173, (funcp)execute_174, (funcp)execute_175, (funcp)execute_176, (funcp)execute_177, (funcp)execute_178, (funcp)execute_179, (funcp)execute_180, (funcp)execute_181, (funcp)execute_182, (funcp)execute_183, (funcp)execute_184, (funcp)execute_185, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_190, (funcp)execute_191, (funcp)execute_192, (funcp)execute_193, (funcp)execute_8, (funcp)execute_9, (funcp)execute_195, (funcp)execute_12, (funcp)execute_597, (funcp)execute_598, (funcp)execute_599, (funcp)execute_600, (funcp)execute_601, (funcp)execute_602, (funcp)execute_17, (funcp)execute_399, (funcp)execute_19, (funcp)execute_20, (funcp)execute_400, (funcp)execute_401, (funcp)execute_402, (funcp)execute_23, (funcp)execute_403, (funcp)execute_499, (funcp)execute_596, (funcp)execute_29, (funcp)execute_797, (funcp)execute_996, (funcp)execute_997, (funcp)execute_998, (funcp)execute_999, (funcp)execute_1000, (funcp)execute_1001, (funcp)execute_796, (funcp)execute_39, (funcp)execute_894, (funcp)execute_895, (funcp)execute_896, (funcp)execute_897, (funcp)execute_898, (funcp)execute_42, (funcp)execute_43, (funcp)execute_45, (funcp)execute_1299, (funcp)execute_1300, (funcp)execute_1301, (funcp)execute_1302, (funcp)execute_1100, (funcp)execute_51, (funcp)execute_1196, (funcp)execute_1197, (funcp)execute_1198, (funcp)execute_1199, (funcp)execute_54, (funcp)execute_55, (funcp)execute_1295, (funcp)execute_1296, (funcp)execute_1297, (funcp)execute_1298, (funcp)execute_58, (funcp)execute_59, (funcp)execute_1401, (funcp)execute_1402, (funcp)execute_1403, (funcp)execute_1404, (funcp)execute_1405, (funcp)execute_1406, (funcp)execute_1407, (funcp)execute_61, (funcp)execute_1504, (funcp)execute_1980, (funcp)execute_1981, (funcp)execute_1982, (funcp)execute_1983, (funcp)execute_1984, (funcp)execute_75, (funcp)execute_2175, (funcp)execute_2271, (funcp)execute_77, (funcp)execute_78, (funcp)execute_2314, (funcp)execute_2315, (funcp)execute_2316, (funcp)execute_2317, (funcp)execute_2318, (funcp)execute_2319, (funcp)execute_2320, (funcp)execute_81, (funcp)execute_2321, (funcp)execute_2322, (funcp)execute_2323, (funcp)execute_93, (funcp)execute_94, (funcp)execute_95, (funcp)execute_2333, (funcp)execute_2334, (funcp)execute_2335, (funcp)execute_2336, (funcp)execute_2337, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_248, (funcp)transaction_253, (funcp)transaction_342, (funcp)transaction_347, (funcp)transaction_440, (funcp)transaction_444, (funcp)transaction_538, (funcp)transaction_543, (funcp)transaction_646, (funcp)transaction_651, (funcp)transaction_737, (funcp)transaction_742, (funcp)transaction_834, (funcp)transaction_838, (funcp)transaction_933, (funcp)transaction_938, (funcp)transaction_1044, (funcp)transaction_1048, (funcp)transaction_1145, (funcp)transaction_1150, (funcp)transaction_1239, (funcp)transaction_1244, (funcp)transaction_1340, (funcp)transaction_1345, (funcp)transaction_1446, (funcp)transaction_1450, (funcp)transaction_1537, (funcp)transaction_1542, (funcp)transaction_1625, (funcp)transaction_1630, (funcp)transaction_1715, (funcp)transaction_1720, (funcp)transaction_1804, (funcp)transaction_1809, (funcp)transaction_1893, (funcp)transaction_1898, (funcp)transaction_2001, (funcp)transaction_2006, (funcp)transaction_2093, (funcp)transaction_2098, (funcp)transaction_2185, (funcp)transaction_2190};
const int NumRelocateId= 301;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/mips_txt_behav/xsim.reloc",  (void **)funcTab, 301);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/mips_txt_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/mips_txt_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/mips_txt_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/mips_txt_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/mips_txt_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
