import os

'''
有8个需要修改的地方
它们主要是和文件位置相关的
在注释中提示
'''

cls = open("log.txt", "w")

# 修改1：魔改版MARS的位置
mars_dir = r"D:\Archive\Auto-Test\PipieCPU50\Mars_Leo.jar"

# 修改2：将要自动生成的十六进制代码的存放位置
hexcode_dir = r'D:\Archive\ISE\PipelineCPU_Update\PipelineCPU_Update.sim\sim_1\behav\xsim\code.txt'

# mipscode_dir在后面生成，这里不用修改
mipscode_dir = r'D:\Archive\Auto-Test\PipieCPU50\Test.asm'

# 修改3：MARS提供的标准输出的存放位置
standard_outdir = r'D:\Archive\Auto-Test\PipieCPU50\std.txt'

# 修改4：analysis文件夹和包含有带.asm后缀的MIPS源代码的位置
walk = os.walk(r'D:\Archive\Auto-Test\PipieCPU50\data_P6')

epoch = 0

while True:
    f = open("log.txt", "a+")
    print("Run {}".format(epoch+1))
    epoch += 1
    os.system(r"D:\Archive\cpp\MIPS\cmake-build-debug\MIPS.exe")
    os.system(
        'java -jar ' + mars_dir + ' ' + mipscode_dir + ' nc mc CompactDataAtZero a dump .text HexText ' + hexcode_dir)  # 编译出十六进制文件
    os.system('java -jar ' + mars_dir + ' 4096 ' + mipscode_dir + ' db nc mc CompactDataAtZero >' + standard_outdir)
    # 进行编译

    # 用vivado进行驱动文件进行对派
    os.system("Vivado -mode batch -source start.tcl")
    file1 = open(r'D:\Archive\ISE\PipelineCPU_Update\PipelineCPU_Update.sim\sim_1\behav\xsim\src.txt')
    l1 = file1.readlines()
    file2 = open(r'D:\Archive\Auto-Test\PipieCPU50\std.txt', encoding='utf-8')
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

    print(l2)
    same = True
    if len(l1) != len(l2):
        same = False
    else:
        for i in range(len(l1)):
            if l1[i].strip() != l2[i].strip():
                print(i, '\n', l1[i], l2[i], file=f)
                same = False
    if not same:
        print('Failure: epoch: {}, result = {}'.format(epoch, same), file=f)
        exit(0)
        break
    print('Suceed, epoch: {}, result = {}'.format( epoch, same), file=f)
    f.close()

