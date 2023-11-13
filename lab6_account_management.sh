#    1. С помощью команд useradd, groupadd, passwd создайте учетную запись user1 со следующими параметрами:
#    • UID - 1500;
#    • основная (первичная) группа user1 (GID 1500);
#    • дополнительная группа - video;
#    • домашний каталог должен быть создан;
#    • входной командный интерпретатор - /bin/bash;
#    • задать пароль по своему усмотрению;
#    • время действия пароля - 60 дней;
#    • пользователь должен сменить пароль при первом входе в систему.
sudo groupadd user1
sudo useradd -u 1500 -g user1 -G video -m -s /bin/bash NewUser
sudo usermod -p 1234 NewUser
sudo passwd --maxdays 60 NewUser #sudo passwd -x 60 NewUser #sudo chage -M 60 NewUser
sudo passwd NewUser #ItsForFree
sudo passwd -e NewUser
sudo chage -l NewUser
#Последний раз пароль был изменён				: пароль должен быть изменён
#Срок действия пароля истекает					: пароль должен быть изменён
#Пароль будет деактивирован через				: пароль должен быть изменён
#Срок действия учётной записи истекает				: никогда
#Минимальное количество дней между сменой пароля			: 0
#Максимальное количество дней между сменой пароля		: 60
#Количество дней с предупреждением перед деактивацией пароля	: 7


#    2. Проверьте, что атрибуты учетной записи и параметры пароля установлены верно (воспользуйтесь командами id и chage), зайдите в систему, 
#используя созданную учетную запись пользователя.
su NewUser
#New password#
id NewUser
#uid=1500(NewUser) gid=1001(user1) группы=1001(user1),44(video)
sudo chage -l NewUser
#Последний раз пароль был изменён				: ноя 02, 2023
#Срок действия пароля истекает					: янв 01, 2024
#Пароль будет деактивирован через				: никогда
#Срок действия учётной записи истекает				: дек 09, 2023
#Минимальное количество дней между сменой пароля			: 0
#Максимальное количество дней между сменой пароля		: 60
#Количество дней с предупреждением перед деактивацией пароля	: 7

#   3. С помощью утилит adduser и addgroup создайте учетную запись user2 со следующими параметрами:
#UID - 2000;
#основная группа user2 (GID 2000);
#дополнительная группа users;
#GECOS: полное имя- Пользователь 2, номер комнаты - 111, рабочий телефон 111-111, остальные поля пустые;
#задайте пароль по своему усмотрению.
sudo addgroup --gid 2000 user2; sudo adduser --uid 2000 --gid 2000 user2
#Добавляется группа «user2» (GID 2000) ...
#Готово.
#Добавляется пользователь «user2» ...
#Добавляется новый пользователь «user2» (2000) в группу «user2» ...
#Создаётся домашний каталог «/home/user2» ...
#Копирование файлов из «/etc/skel» ...
#Новый пароль: 
#Повторите ввод нового пароля: 
#passwd: пароль успешно обновлён
#Изменение информации о пользователе user2
#Введите новое значение или нажмите ENTER для выбора значения по умолчанию
#	Полное имя []: Пользователь 2
#	Номер комнаты []: 111
#	Рабочий телефон []: 111-111
#	Домашний телефон []: 
#	Другое []: 
#chfn: имя «Пользователь 2» содержит не ASCII-символы
#Данная информация корректна? [Y/n]
Y

#    4. Проверьте, что учетная запись создана согласно требованиям из предыдущего пункта (используйте команду lslogins) и зайдите в систему под учетной записью user2.
lslogins
#1500 NewUser                1                              
#2000 user2                  0                              Пользователь 2,111,111-111,
su user2
#    5. Измените обои у новых пользователей:
#преобразуйте файл /usr/share/images/destop-base/spacefun-wallpaper-widescreen.svg в png формат. Используйте команду rsvg-convert. Сохраните файл в каталоге /usr/share/images под именем spacefun.png.
#Укажите в файле настройки темы имя файла с новыми обоими (параметр WallPaper), обои растянуть на весь экран (параметр WallPaperPos).
sudo rsvg-convert -f png -o /usr/shared/images/desktop-base/spacefun-wallpaper-widescreen.svg
#Заменить в файле default.themerc строку WallPaper=fly-default на WallPaper=/usr/shared/images/spacefun.png
sudo sed -i 's/^WallPaper=.*/WallPaper=\/usr\/share\/images\/spacefun.png' /usr/share/fly-wm/theme/default.themerc
#fly-default
#растянуть обои (WallPaperPos = Stretch)
sudo sed -i 's/WallPaperPos =.*/WallPaperPos = Stretch/' /usr/share/fly-wm/theme/default.themerc
#Crop

#    6. С помощью графической утилиты (fly-admin-smc) создайте учетную запись user3 со следующими параметрами:
#    • UID - 2500:
#    • основная группа user3 (GID 2500);
#    • дополнительные группы: users, cdrom;
#    • задайте пароль по своему усмотрению;
#    • время действия пароля - 30 дней;
#    • минимальное время между сменой пароля - 14 дней;
#    • время неактивности пользователя после окончания действия пароля – 60 дней.
sudo fly-admin-smc
#    7. Проверьте, что параметры учетной записи user3 соответствуют заданию.
#Зайдите этим пользователем в графическое окружение и убедитесь, что обои - новые.

#    8. Настройте PAM так, чтобы запоминалось 5 последних паролей пользователей, не давая их использовать при очередной смене пароля Проверьте, что нельзя использовать предыдущие пароли. Примечание: изучите man-страницу по модулю pam_unix.
sudo nano /etc/pam.d/common-password
#Добавляем строку в файл:
#password   required    pam_unix.so remember=5

#    9. Когда passwd запускается от имени пользователя root, то можно задавать «плохие» пароли, несмотря на предупреждение команды passwd. Настройте PAM так, чтобы и пользователь root не мог задавать пароли из словаря. Проверьте, что пользователь root должен придерживаться тех же правил формирования пароля, что и обычные пользователи. Примечание: изучите man-страницу по модулю pam_cracklib.
sudo nano /etc/pam.d/common-password
#Добавляем строку в файл:
#password   required    pam_cracklib.so enforce_for_root
#Проверяем:
sudo passwd user3
#qwertyui
#BAD PASSWORD: The password fails the dictionary check
#    10. Задайте любое значение переменной окружения VAR в файле /etc/environment.

#    11. Проверьте, что при входе в систему переменная VAR определена.

#    12. Заблокируйте учетную запись user3.
sudo passwd -l user3 #--lock
#Или sudo usermod -L user3

#chmod +x ./file.sh
#длина > 5  1мал 1 бол 1 цифр + доп симв
#послед 4 симв не совпадает с другими паролями
sudo nano /etc/login.defs
# Make sure 5 characters in new password are new compared to old password
difok = 5
# Set the minimum length acceptable for new passwords
minlen = 15
# Require at least 2 digits
dcredit = -2
# Require at least 2 upper case letters
ucredit = -2
# Require at least 2 lower case letters
lcredit = -2
# Require at least 2 special characters (non-alphanumeric)
ocredit = -2
# Require a character from every class (upper, lower, digit, other)
minclass = 4
# Only allow each character to be repeated twice, avoid things like LLL
maxrepeat = 2
# Only allow a class to be repeated 4 times
maxclassrepeat = 4
# Check user information (Real name, etc) to ensure it is not used in password
gecoscheck = 1
# Leave default dictionary path
dictpath =
# Forbid the following words in passwords
badwords = password pass word putorius


#https://forum.astralinux.ru/threads/708/
#https://habr.com/ru/companies/otus/articles/448996/
#https://itsecforu.ru/2019/02/18/%D0%BA%D0%B0%D0%BA-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D0%BD%D0%B8%D1%82%D1%8C-%D0%BF%D0%BE%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%D1%83-%D0%BD%D0%B0%D0%B4%D0%B5%D0%B6%D0%BD%D1%8B%D1%85-%D0%BF%D0%B0%D1%80%D0%BE/
