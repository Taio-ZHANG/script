#!/bin/bash
for inf in *.inp
do
echo Running ${inf} ...
time /home/ABC/ORCA/orca421/orca ${inf} > ${inf//inp/out}
echo ${inf} is finished
echo
done

for inf in *.gbw
do
orca_2mkl ${inf//.gbw/} -molden
done

for inf in *.molden.input
do
mv ${inf} ${inf//.input/}
done
