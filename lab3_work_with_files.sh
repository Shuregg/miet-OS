#6-7 пара XV6 суббота числитель
#cp *from* *to*         #copy
#mv *from* *to*         #move
#rm                     #remove

#rm -r                  #recursion parameter  - удалить всё внутри каталога
#mv IVT-33 IVT-32       #rename the file

#find                   #поиск
#grep                   #осуществляет поиск строк по типу 
#tree (надо установить)        #красивый вывод иерархии

#find *полный путь*
#find . -name fileanme
#find . -type filename

#grep 'filename' 'where to find'
#grep 'file.txt' '~'
#grep -r hello! (ищет hello! по содержимому в файле)

#tree | grep LAB #выведет всё в дереве, что содержит 'LAB'

#полезные команды
#mkdir IVT{1..3} - создать 3 папки

#gcc *.c #компиляция всех файлов
##Изучить регулярные выражения

#1.5-1.7
cd ./D3
ln ../D2/file.txt ./hardlink.txt                 #жёсткая ссылка
ln -s ../D2/file.txt ./symblink.txt           #символическая
cd ../D2
ls -l                               #-итого 4
cd ..
mv ./D2/file.txt ./D1/file.txt
cd ./D3
ls
cat hardlink.txt #читается
cat symblink.txt #нет такого файла или каталога
rm -r D2
#https://younglinux.info/bash/link


#2.1-2.5
find / -size +50M #поиск файлов в домашнем каталоге больше(!) 50 Мбайт


find ~ -mtime -1 #Какие файлы модифицировались за последние 24 часа

whereis find #usr/bin/find местонахождение утилиты find
which find

nano /usr/bin/find #Отрытие утилиты find 

cd /boot && file initrd.img* #определение типа файлов

#3.1 - 3.4
cd /var/log && less auth.log
	#less -N вывод номеров строк
less -r auth.log #print in reverse order

pwd && ls #print current directory path and including files

cd ~/Study/miet-os/ && (pwd && ls) > cur_dir_files.txt #save current directory path and including files to cur_dir_files.txt

#4.1 - 4.4
cd ~ || grep '^d' #вывод только каталогов
ls -l | grep '^d' | cut --fields=9-10 -d' ' #вывод только имён каталогов
ls -l | grep '^d' | cut --fields=9-10 -d' ' | tr '\n' '\ ' #вывести имена каталогов в одну строку
ls -l | grep '^d' | cut --fields=9-10 -d' ' | tr '\n' '\ ' >> ~/Study/miet-os/cur_dir_files.txt #Добавить эту строку в файл

ls -l | cut --bytes=1-10 | sort| uniq | echo $[$(wc -l)-1] #Вывести количество различных комбинаций прав доступа, установленных на файлы и каталоги в /dev/

#5.1 - 5.4

#5.1 grep
man -k '^ls' | grep '^ls'

#5.2 grep

#5.3 sed

