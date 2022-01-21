import os

'''
有8个需要修改的地方
它们主要是和文件位置相关的
在注释中提示
'''

f = open("log.txt", "w")

# 修改1：魔改版MARS的位置
mars_dir = r"D:\Archive\Auto-Test\PipieCPU50\Mars_Leo.jar"

# 修改2：将要自动生成的十六进制代码的存放位置
hexcode_dir = 'D:\\Archive\\the1\\mips\\code.txt'

# mipscode_dir在后面生成，这里不用修改
mipscode_dir = ''

# 修改3：MARS提供的标准输出的存放位置
standard_outdir = 'D:\\Archive\\the1\\mips\\std.txt'

# 修改4：analysis文件夹和包含有带.asm后缀的MIPS源代码的位置
walk = os.walk('D:\\Archive\\P5tester\\analysis\\work\\P5_LX_github')

epoch = 0
for path1, docu_list, file_list in walk:
    for file_name in file_list:
        if '.asm' in file_name:
            mipscode_dir = os.path.join(path1, file_name)

            epoch = epoch + 1
            os.system(
                'java -jar ' + mars_dir + ' ' + mipscode_dir + ' nc mc CompactDataAtZero a dump .text HexText ' + hexcode_dir)  # 编译出十六进制文件
            os.system('java -jar ' + mars_dir + ' 4096 ' + mipscode_dir + ' db nc mc CompactDataAtZero >' + standard_outdir)
            # 进行编译

            # 用vivado进行驱动文件进行对派
            #os.system("Vivado -mode batch -source start.tcl")

            # 开始比对两个文件
            # 修改7：我的ISE在前8行会输出编译的信息，所以删除掉
            # 请观察你的ISE输出并适当的修改
            os.system("iverilog -o love.out alu.v ALUctr.v CmpMode.v conflict.v datapathD.v datapathE.v datapathF.v  "
                      "datapathM.v datapathW.v E_M.v forwardD.v ID_E.v IF_ID.v instruction.v M_W.v MdMode.v MemMode.v "
                      "mips.v mips_test.v moduleD.v moduleF.v moduleM.v moduleW.v type_judge.v")
            os.system("vvp love.out")

            file1 = open('D:\\Archive\\the1\\mips\\love.txt')
            l1 = file1.readlines()
            file2 = open('D:\\Archive\\the1\\mips\\std.txt', encoding='utf-8')
            l2 = file2.readlines()

            newl1 = []
            newl2 = []

            for i in range(len(l1)):
                if l1[i] != '\n':
                    newl1.append(l1[i])
            for i in range(len(l2)):
                if l2[i] != '\n' and l2[i] != "Program terminated when maximum step limit 4096 reached.\n":
                    newl2.append(l2[i])
            l1 = newl1
            l2 = newl2

            same = True
            if len(l1) != len(l2):
                same = False
            else:
                for i in range(len(l1)):
                    if l1[i].strip() != l2[i].strip():
                        print(i, '\n', l1[i], l2[i])
                        same = False
            if not same:
                print('Failure in: ', file_name, '  epoch: {}, result = {}'.format(epoch, same))
                break
            print('File: {} epoch: {}, result = {}'.format(file_name, epoch, same))

"""
            #修改5：ISE/fuse/prj/conf四个文件的位置，详情见@何梓源同学的帖子
            os.environ['XILINX'] = 'D:\\ise_full\\14.7\\ISE_DS\\ISE'
            fuse_dir = 'D:\\ise_full\\14.7\\ISE_DS\\ISE\\bin\\nt64\\fuse'
            prj_dir = 'D:\\ISE_codes\\p5_version2\\testprj.prj'
            tcl_dir = 'D:\\ISE_codes\\p5_version2\\conf.tcl'

            #使用编译产生的可执行文件，输出CPU的答案
            #修改6：这里ISE的输出会在test.py当前的文件夹下面输出
            #如果需要的话，需要指定ISE输出文件的位置
            os.system(fuse_dir + ' -nodebug -prj ' + prj_dir + ' -o testX.exe tester>log.txt')
            os.system('testX.exe -nolog -tclbatch '+ tcl_dir + '> answer_fromISE.txt')      
"""
