#   ls -l   #   for file
#   ls -ld  #   for dir
#   chown   #   change file owner and group
#   chgrp
#   chmod   #   change file mode bits
#   umask   #   set file mode creation mask (задание прав для создаваемых файлов)
#   fly-fm  #   file manager
#   mc      #   Midnight Commander (file manager)

#example:   
#chown -R owner files_names         #only root can use it
#chown -R owner.group files_names   #UID can be used instead of <owner>
#chgrp -R group files_names         #смена группы-владельца у файла     #root and owner can use it  #GID can be used insted of <group>

#chmod -R <rights_of_files_or_dirs>
#chmod g+w, o-r file.txt

#touch access_rights_test_file.txt
#ls -l access_rights_test_file.txt 
#-rw-rw-r-- 1 alexander alexander 0 ноя 13 13:56 access_rights_test_file.txt


#clear; find / -type f -perm /u+s -o -perm /g+s

#Задание 1. Поиск файлов с заданными правами доступа:
#1.1    Найдите все регулярные (обычные, regular) файлы, у которых установлены
#биты suid и/или sgid. Во время поиска осуществляйте проверку, что найдены именно требуемые файлы.
#sudo find / -type f -perm /u+s -o -perm /g+s -exec stat -c "%A %n" {} \;
sudo find / -type f -perm /u+s,g+s

ls -l /usr/bin/mountz
#-rwsr-xr-x 1 root root 47480 фев 21  2022 /usr/bin/mount
ls -l /usr/bin/su
#-rwsr-xr-x 1 root root 55672 фев 21  2022 /usr/bin/su
ls -l /usr/bin/sudo
# -rwsr-xr-x 1 root root 232416 апр  3  2023 /usr/bin/sudo
ls -l /usr/bin/chage
# -rwxr-sr-x 1 root shadow 72184 ноя 24  2022 /usr/bin/chage



#1.2    Сохраните результат поиска (абсолютные имена файлов) в файл suid_sgid.txt
#sudo find / -type f -perm /u+s -o -perm /g+s -exec stat -c "%A %n" {} \; > ./suid_sgid.txt
sudo find / -type f -perm /u+s,g+s > ./suid_sgid.txt


# 1.3В каких каталогах больше всего файлов с установленными suid и/или sgid битами?
find / -type f -perm /u+s,g+s -printf '%h\n' | sort | uniq -c | sort -nr
#/usr/bin
#Эта команда выведет список каталогов с количеством файлов с установленными битами suid и/или sgid, отсортированных в порядке убывания количества файлов.

# 1.4 Сколько файлов имеют установленный бит suid?
sudo find / -type f -perm /u+s > ./suid.txt
cat suid.txt | wc -l    #64

# 1.5 Сколько файлов имеют установленный бит sgid?
sudo find / -type f -perm /g+s > ./sgid.txt
cat sgid.txt | wc -l    #35



# 1.6 У скольких файлов установлен и suid и sgid биты?
cat ./suid_sgid.txt | wc -l
sudo find / -type f \( -perm -4000 -a -perm -2000 \) 
sudo find / -type f \( -perm -4000 -a -perm -2000 \) | wc -l

# Задание 2. Изменение дискреционных прав доступа:
# 2.1 Задайте значение маски режима доступа (пользовательской маски) так, чтобы права были только у владельца
umask 0077

# 2.2 В своем домашнем каталоге создайте ветку каталогов tmp1/tmp2/tmp3/tmp4/tmp5
mkdir -p ~/tmp1/tmp2/tmp3/tmp4/tmp5

# 2.3 В каталогах tmp2 и tmp4 создайте файлы с именами file2 и file4 соответственно.
touch ~/tmp1/tmp2/file2; touch ~/tmp1/tmp2/tmp3/tmp4/file4
tree ~/tmp1
# /home/alexander/tmp1
# └── tmp2
#     ├── file2
#     └── tmp3
#         └── tmp4
#             ├── file4
#             └── tmp5

# 2.4 Проверьте, какие права доступа установлены на созданные файлы и каталоги.
ls -l ~/tmp1/tmp2/file2; ls -l ~/tmp1/tmp2/tmp3/tmp4/file4
#-rw------- 1 alexander alexander 0 ноя 16 20:36 /home/alexander/tmp1/tmp2/file2
#-rw------- 1 alexander alexander 0 ноя 16 20:36 /home/alexander/tmp1/tmp2/tmp3/tmp4/file4


# 2.5 Используя команду find, измените права доступа на все каталоги начиная с tmp2
# так, чтобы группа-владелец имела все права доступа, а все остальные могли бы
# только просматривать содержимое каталогов. Права доступа на файлы file2 и
# file4 должны остаться прежними.
find ~/tmp1/tmp2 -type d -exec chmod 0750 {} +
ls -ld ~/tmp1/tmp2; ls -ld ~/tmp1/tmp2/tmp3/ ;ls -ld ~/tmp1/tmp2/tmp3/tmp4
#drwxr-x--- 3 alexander alexander 4096 ноя 16 20:35 /home/alexander/tmp1/tmp2
#drwxr-x--- 3 alexander alexander 4096 ноя 16 20:33 /home/alexander/tmp1/tmp2/tmp3/
#drwxr-x--- 3 alexander alexander 4096 ноя 16 20:36 /home/alexander/tmp1/tmp2/tmp3/tmp4

#Эта команда найдет все каталоги, начиная с tmp2, и изменит права доступа на 0750, где 0 - права для "владельца", 7 - права для "группы-владельца" и 5 - права для "остальных пользователей". Права доступа на файлы file2 и file4 останутся прежними.



# Задание 3. Создание общих каталогов для пользователей с использованием общей группы и установкой бита sgid на каталог
#3.1 Создайте каталог /home/Dir1.
mkdir ~/Dir1

#3.2 Создайте учетные записи user1 и user2 (если они не были созданы ранее).
sudo useradd -u 1500 -G video -m -s /bin/bash user1; sudo adduser user2

#3.3 Создайте группу shtat. Поместите пользователей user1 и user2 в группу shtat (вторичная группа)
sudo groupadd shtat
sudo usermod -aG shtat user1; sudo usermod -aG shtat user2

#3.4 Сделайте так, чтобы участники группы shtat (пользователи user1 и user2) могли создавать и редактировать файлы в каталоге /home/Dir1. При этом остальные пользователи не должны иметь доступ к файлам в /home/Dir1.
sudo chown -R root:shtat ~/Dir1; 
sudo chmod 770 ~/Dir1; 
sudo chmod g+s ~/Dir1

ls -ld ~/Dir1/
#rwxrwx--- 2 root shtat 4096 ноя 16 20:58 /home/alexander/Dir1/

#3.5 С помощью PAM-модуля pam_umask.so задать для учетных записей user1 и user2
#маски режима доступа (пользовательские маски) так, чтобы группа-владелец имела все права на создаваемые файлы.
sudo nano /etc/pam.d/common-session
#session optional pam_umask.so umask=002

#3.6 Зайти под учетной записью user1 и создать файл project1.txt в каталоге /home/Dir1. Записать в этот файл текущую дату.
su user1
cd ~/Dir1
echo $(date) > project1.txt
exit


#3.7 Зайти под учетной записью user2 и изменить файл /home/Dir1/project1.txt, добавив информацию о текущей версии Astra Linux.
su user2
cd /home/Dir1
cat /etc/astra_version >> project1.txt
exit


# Задание 4. Создание общих каталогов для пользователей с использованием файловых списков доступа
# Создайте каталог /home/Dir2
mkdir ~/Dir2
# С помощью пользовательских списков доступа сделайте так, чтобы пользователи
# user1 и user2 могли создавать/удалять файлы и каталоги внутри /home/Dir2, а также
# изменять содержимое файлов. При этом, никто другой не может видеть
# содержимое внутри общего каталога.
sudo setfacl -m u:user1:rwx ~/Dir2
sudo setfacl -m u:user2:rwx ~/Dir2
sudo setfacl -m o:--- ~/Dir2

# Зайти под учетной записью user1 и создать файл project2.txt в каталог /home/Dir2.
# Записать в этот файл дату и время последней загрузки системы.
su user1
cd /home/Dir2
echo "Date and time of last system booting $(date)" > project2.txt
exit
# Зайти под учетной записью user2 и изменить файл /home/Dir2/project2.txt, добавив
# информацию о кодовом имени данного выпуска Astra Linux.
su user2
cd ~/Dir2
lsb_release -a > project2.txt
exit

# Задание 5. Использование атрибута файла a (append)
# 5.1 Создайте в домашнем каталоге файл my.log.
touch ~/my.log

# 5.2 Установите на файл my.log атрибут a (append).
sudo chattr +a ~/my.log

# 5.3 Попробуйте: удалить файл, изменить файл в редакторе, добавить информацию в
# конец файла. Действия делайте как под своей учетной записью, так и под учетной
# записью root.
rm ~/my.log #Операция не позволена

nano ~/my.log #Операция не позволена

echo "info" >> ~/my.log #ОК

sudo rm ~/my.log #Операция не позволена

sudo nano ~/my.log #Операция не позволена

sudo cat ~/my.log #ОК
# Вопросы для проверки
# 1. Какая команда разрешит выполнять файл script1 всем пользователям?
#Чтобы разрешить выполнение файла script1 всем пользователям, вы можете использовать команду chmod с аргументом +x. Вот команда:
chmod +x script1
#Это добавит исполняемый (execute) бит для всех пользователей для файла script1, позволяя им выполнять его.

# 2. У каталога установлены права rwx-sx--x. Переведите права в числовую форму.
#Права доступа rwx-sx--x могут быть переведены в числовую форму следующим образом: r = 4, w = 2, x = 1.
#Флаг s в позиции "владелец" означает установленный бит SUID.
#Таким образом, перевод числовой формы будет: rwx-sx--x = 2(-s-)7(владелец)3(группа)1(остальные)
#2731

# 3. Сделайте так, чтобы пользователь user1 мог изменять содержимое новых файлов в каталоге Dir.
#Для того чтобы пользователь user1 мог изменять содержимое новых файлов в каталоге Dir, вам нужно изменить группу владельца каталога на группу, к которой user1 принадлежит, и установить на каталог доступ на запись для группы. Вот команды:
chgrp user1 Dir  # user1 - имя группы, которой принадлежит user1
chmod g+w Dir
#Теперь user1 сможет изменять содержимое новых файлов в каталоге Dir.