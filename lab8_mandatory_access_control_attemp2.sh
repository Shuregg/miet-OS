1.1 Зайти в систему администратором и получить права root
sudo su

1.2 Переименовать уровни конфиденциальности
echo "for_all 0" >> /etc/security/confidentiality_levels
echo "secret 1" >> /etc/security/confidentiality_levels
echo "very_secret 2" >> /etc/security/confidentiality_levels
echo "very_important 3" >> /etc/security/confidentiality_levels

1.3 Создать учетную запись для пользователя ivanov
useradd -m -G users ivanov
setfattr -n security.level -v for_all /home/ivanov
setfattr -n security.max_level -v very_secret /home/ivanov

1.4 Создать учетную запись для пользователя petrov
useradd -m -G users petrov
setfattr -n security.level -v for_all /home/petrov
setfattr -n security.max_level -v secret /home/petrov
2.1 Создать каталог /home/project
mkdir /home/project
setfattr -n security.level -v very_important /home/project
setfattr -n user.ccnr -v 1 /home/project

2.2-2.3 Создать каталоги и установить уровни конфиденциальности
mkdir /home/project/secret
setfattr -n security.level -v secret /home/project/secret

mkdir /home/project/very_secret
setfattr -n security.level -v very_secret /home/project/very_secret

2.4 Установить ACL
setfacl -m u:ivanov:rwcd /home/project/secret
setfacl -m u:petrov:rwcd /home/project/secret
setfacl -d -m u:ivanov:rwcd /home/project/secret
setfacl -d -m u:petrov:rwcd /home/project/secret

setfacl -m u:ivanov:rwcd /home/project/very_secret
setfacl -m u:petrov:rwcd /home/project/very_secret
setfacl -d -m u:ivanov:rwcd /home/project/very_secret
setfacl -d -m u:petrov:rwcd /home/project/very_secret
3.1 Вход под учетной записью ivanov с уровнем конфиденциальности secret
su - ivanov

3.2-3.3 Создание, изменение и сохранение файла file1.txt
echo "ivanov" > /home/project/secret/file1.txt
Успешно ли завершились предыдущие шаги?
3.4 Виден ли каталог /home/project/very_secret
ls /home/project/very_secret
Ответ: Нет
3.5 Вход под учетной записью ivanov с уровнем конфиденциальности very_secret
su - ivanov

3.6-3.7 Создание, изменение и сохранение файла file2.txt
echo "ivanov" > /home/project/very_secret/file2.txt
Успешно ли завершились предыдущие шаги?
3.8 Виден ли каталог /home/project/secret
ls /home/project/secret
Ответ: Нет
3.9 Виден ли файл /home/project/secret/file1.txt
cat /home/project/secret/file1.txt
Ответ: Нет
4.1 Добавить строку в файл /home/project/secret/file1.txt
echo "ivanov2" >> /home/project/secret/file1.txt
Удалось ли изменить содержимое файла?
4.2 Вход под учетной записью petrov с уровнем конфиденциальности secret
su - petrov

4.3 Добавить строку в файл /home/project/secret/file1.txt
echo "petrov" >> /home/project/secret/file1.txt
Удалось ли изменить содержимое файла?
4.4 Можно ли прочитать содержимое файла /home/project/very_secret/file2.txt
cat /home/project/very_secret/file2.txt
Ответ: Нет
4.5 Добавить пользователя user2 в группу wheel
usermod -aG wheel user2

4.6 Вход под учетной записью user2
su - user2

4.7 Выполнение команд от имени root
sudo whoami
Ответ: root