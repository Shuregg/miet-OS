#1.3
tty  			# /dev/pst/0    это - Виртуальный термирнал

#1.4 откр. вкладку
tty 			#  /dev/pst/1

#1.5
ls dev/pts

#2.1
chvt 3
#2.2
tput cols && tput lines

#3.1
ls #press tab

#3.2
$HIST #press tab

#3.3
echo $HISTFILESIZE #2000
echo $HISTCMD      #876
echo $HISTSIZE     #1000
#4.1
ls .c*

#4.2
export HISTTIMEFORMAT="%F %T "
history

#4.3
date
history
cat $HISTFILE
PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
source ~/.bashrc
whoami
cat $HISTFILE

#4.4
export DATE=$(date +"%d.%m.%y")
export TIME=$(date +"%T")
export DATE_TIME=$DATE\ $TIME

#5.1
find ~ *0* *1* *2* *3* *4* *5* *6* *7* *8* *9*
ls *[0-9]* #better variant

#5.2
sudo update-alternatives --config editor
#выбираем номер mcedit

#5.3
#export PS1="\u@\h-\A " #чисто bash команды
export PS1="\u@\h-$(date +"%H:%M")" #bash + date

#5.4
#всё по умолчанию

#5.5
nano ~/.bashrc
#в конце файла прописываем новое приглашение PS1=""
PS1="\e[0;35m\u@\h\em \e[0;96m \A\em\e[0;97m\em>"
source ~/.bashrc 	#для применения изменений без перезапуска

#5.6
mkdir $(date +"%Y")-{1..12}
ls

#Контрольные вопросы
#1  sudo

#2
mkdir -p {2019..2021}/{1..12}
#rm -R 20??

#3
touch "$(whoami)-$(hostname)-$(date +"%d-%m-%y")"

