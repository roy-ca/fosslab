#!/bin/bash

#converting pdf file to text file
pdftotext -layout s1.pdf s1.txt
pdftotext -layout s2.pdf s2.txt

#removing spaces tabs commas from text files
tr -d '\040\011\012\015\014\054'< s1.txt> copy1.txt
tr -d '\040\011\012\015\014\054'< s2.txt>copy2.txt

#To make each row in seperate lines 
sed -i 's/MDL16CS/\nMDL16CS/g' copy1.txt
sed -i "s/ELECTRONICS/\nELECTRONICS/g" copy1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' copy2.txt
sed -i "s/ELECTRONICS/\nELECTRONICS/g" copy2.txt

#To remove the grades of all other branches
grep MDL16CS copy1.txt > s1CS.txt
grep MDL16CS copy2.txt > s2CS.txt

#To remove names of subjects with space
sed -i "s/MA101(/ /g" s1CS.txt
sed -i "s/PH100(/ /g" s1CS.txt
sed -i "s/BE110(/ /g" s1CS.txt
sed -i "s/BE10105(/ /g" s1CS.txt
sed -i "s/BE103(/ /g" s1CS.txt
sed -i "s/EE100(/ /g" s1CS.txt
sed -i "s/PH110(/ /g" s1CS.txt
sed -i "s/EE110(/ /g" s1CS.txt
sed -i "s/CS110(/ /g" s1CS.txt
sed -i "s/)/ /g" s1CS.txt

sed -i "s/EC100(/ /g" s2CS.txt
sed -i "s/CY100(/ /g" s2CS.txt
sed -i "s/BE100(/ /g" s2CS.txt
sed -i "s/CY110(/ /g" s2CS.txt
sed -i "s/EC110(/ /g" s2CS.txt
sed -i "s/MA102(/ /g" s2CS.txt
sed -i "s/BE102(/ /g" s2CS.txt
sed -i "s/CS100(/ /g" s2CS.txt
sed -i "s/CS120(/ /g" s2CS.txt
sed -i "s/)/ /g" s2CS.txt

#To remove grades with gradepoint



sed -i "s/O/10/g" s1CS.txt
sed -i "s/A+/9/g" s1CS.txt
sed -i "s/A/8.5/g" s1CS.txt
sed -i "s/B+/8/g" s1CS.txt
sed -i "s/B/7/g" s1CS.txt
sed -i "s/C/6/g" s1CS.txt
sed -i "s/P/5/g" s1CS.txt
sed -i "s/F/0/g" s1CS.txt

sed -i "s/O/10/g" s2CS.txt
sed -i "s/A+/9/g" s2CS.txt
sed -i "s/A/8.5/g" s2CS.txt
sed -i "s/B+/8/g" s2CS.txt
sed -i "s/B/7/g" s2CS.txt
sed -i "s/C/6/g" s2CS.txt
sed -i "s/P/5/g" s2CS.txt
sed -i "s/F/0/g" s2CS.txt

sed -i "s/166/16C/g" s1CS.txt
sed -i "s/166/16C/g" s2CS.txt

#To remove the electronics from the end
grep -v "ELE6TR10NI6S" s1CS.txt > temp1.txt
grep -v "ELE6TR10NI6S" s1CS.txt > temp2.txt

>s1GPA.txt
>s2GPA.txt

#To read the file line by line

mapfile < s1CS.txt

for i in `seq 0 122`
do
  temp=(${MAPFILE[$i]})
  sum=$(printf "%.1f" "$(echo "((${temp[1]} *4) + (${temp[2]} * 4) + (${temp[3]} * 3) + (${temp[4]} * 3) + (${temp[5]} *3) + (${temp[6]} *3) + (${temp[7]}) + ${temp[8]} + ${temp[9]})/23"|bc -l)")
  echo "$sum" >> s1GPA.txt
done

paste s1CS.txt s1GPA.txt> s1SGPA.txt

sed -i 's/T6E16CS006/\nT6E16CS006/g' s2CS.txt

grep -v "T6E16CS" s2CS.txt> S2CS.txt

mapfile < S2CS.txt

for i in `seq 0 122`
do
  tmp=(${MAPFILE[$i]})
  sum=$(printf "%.1f" "$(echo "((${tmp[1]} *4) + (${tmp[2]} * 4) + (${tmp[3]} * 3) + (${tmp[4]} * 1) + (${tmp[5]} *1) + (${tmp[6]} *4) + (${tmp[7]} *3) + (${tmp[8]} *3) + ${tmp[9]})/24"|bc -l)")
  echo "$sum" >> s2GPA.txt
done

paste S2CS.txt s2GPA.txt> s2SGPA.txt

paste s2SGPA.txt s1SGPA.txt | awk '{printf "%s  %.1f\n",$1,($11 *24 + $22 *23)/47}'> CGPA.txt

#To seperate the cgpa of c4B students

join -1 6 -2 1 c4B.txt CGPA.txt > c4Bcgpa.txt


