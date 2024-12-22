#!/bin/bash  
  
# 创建一个名为output的文件夹（如果不存在的话）  
mkdir -p output  
  
for inf in *.cif  
do  
    echo "Running $inf ..."  
    # 提取文件名（不带扩展名）  
    filename=$(basename -- "$inf")  
    filename_noext="${filename%.cif}"  
      
    # 运行 Multiwfn，将输出文件保存到output文件夹中  
    Multiwfn "$inf" < multiwfncp2k.txt > /dev/null  
    mv cp2k "output/${filename_noext}.inp"  
done  
  
# 在所有inp文件生成以后，执行以下步骤  
echo "All inp files have been generated. Modifying inp files to ignore convergence failure..."  
for inp in output/*.inp  
do  
    # 查找文件中的 '# IGNORE_CONVERGENCE_FAILURE' 行并删除前面的井号  
    sed -i 's/^# *IGNORE_CONVERGENCE_FAILURE/IGNORE_CONVERGENCE_FAILURE/' "$inp"  
done