pdp-ls -M   #or -Md for dirs only

#определение уровня доступа
fly-admin-smc   #GUI
userlev         #get and set privacy levels

# Задание 1
# 1.1. Зайдите в систему администратором. Получите права root.
sudo su
# 1.2. Переименуйте уровни конфиденциальности:
# 0 — for_all
# 1 — secret
# 2 — very_secret
# 3 — very_important
sudo userlev
sudo userlev -r for_all 0
sudo userlev -r secret 1
sudo userlev -r very_sectet 2
sudo userlev -r very_important 3
sudo userlev

# 1.3. Создайте учетную запись для пользователя ivanov.
# a)минимальный уровень конфиденциальности — for_all.
# b)максимальный уровень конфиденциальности — very_secret
useradd ivanov
sudo pdpl-user -l 0:2 ivanov
# 1.4. Создайте учетную запись для пользователя petrov
# a)минимальный уровень конфиденциальности — for_all
# b)максимальный уровень конфиденциальности — secret
useradd petrov
sudo pdpl-user -l 0:1

#или fly-admin-smc: Пользователи->ivanov->МРД

# Задание 2
fly-fm
# 2.1. Создайте каталог /home/project. Установите на каталог уровень конфиденциальности very_important и установите дополнительный атрибут ccnr.
sudo mkdir /home/project
sudo pdpl-file very_important:::ccnr /home/project
sudo pdp-ls -Md /home/project
# sudo mkdir /home/project/very_important
# sudo pdpl-file 0:0:0:1 /home/project/very_important

# 2.2.Создайте каталог /home/project/secret. Установите на каталог уровень конфиденциальности secret.
sudo mkdir /home/project/secret
pdpl-file secret::: /home/project/secret
pdp-ls -Md /home/project/secret
# 2.3. Создайте каталог /home/project/very_secret. Установите на каталог уровень конфиденциальности very_secret.
sudo mkdir /home/project/very_secret
pdpl-file very_secret::: /home/project/very_secret
pdp-ls -Md /home/project/very_secret

# 2.4.Установите файловые списки управления доступом (ACL) и файловые списки управления доступом по умолчанию (default ACL) на каталоги /home/project/secret и /home/project/very_secret, позволяющие пользователям ivanov и petrov создавать и удалять файлы в этих каталогах и изменять содержимое созданных файлов.
sudo setfacl -R -m u:ivanov:rwx,d:u:ivanov:rwx /home/project/secret
sudo setfacl -R -m u:petrov:rwx,d:u:petrov:rwx /home/project/secret
sudo setfacl -R -m u:ivanov:rwx,d:u:ivanov:rwx /home/project/very_secret
sudo setfacl -R -m u:petrov:rwx,d:u:petrov:rwx /home/project/very_secret

# Задание 3
# 3.1. Зайдите в систему под учетной записью ivanov с уровнем конфиденциальности secret.

# 3.2. Создайте файл file1.txt в каталоге /home/project/secret. В этот файл добавьте строку ivanov. Сохраните файл.
touch /home/project/secret/file1.txt
echo "ivanov" > /home/project/secret/file1.txt
# 3.3. Удалось ли создать, изменить и сохранить файл file1.txt?
# ДА!
# 3.4. Виден ли каталог /home/project/very_secret?
# НЕТ!
# 3.5. Зайдите под учетной записью ivanov в систему с уровнем конфиденциальности very_secret.

# 3.6. Создайте файл file2.txt в каталоге /home/project/very_secret. В этот файл добавьтестроку ivanov. Сохраните файл.
touch /home/project/very_secret/file2.txt
echo "ivanov" > /home/project/very_secret/file2.txt
# 3.7. Удалось ли создать, и изменить и сохранить файл file2.txt?
# ДА!
# 3.8. Виден ли каталог /home/project/secret?
# ДА!
# 3.9. Виден ли файл /home/project/secret/file1.txt?
# ДА!

# Задание 4
# 4.1. Добавьте в файл /home/project/secret/file1.txt строку ivanov2.
echo "ivanov2" >> /home/project/secret/file1.txt
# 4.2. Удалось ли изменить содержимое этого файла?
# НЕТ!
# 4.3. Зайдите в систему под учетной записью пользователем petrov с уровнем конфиденциальности secret.

# 4.4 .Добавьте в файл /home/project/secret/file1.txt строку petrov.
echo "petrov" >> /home/project/secret/file1.txt
# 4.5. Удалось ли изменить содержимое этого файла?
# ДА!
# 4.6. Можете ли Вы прочитать содержимое файла /home/project/very_secret/file2.txt?
cat /home/project/very_secret/file2.txt
# Отказано в доступе
# 4.7. Сделайте пользователя user2 администратором. Проверьте, что данный пользователь может выполнять команды от имени пользователя root.
pdpl-user -l 0:3 -i 63 user2
usermod -aG sudo user2















# Вопросы для проверки:
# 1. Из каких компонент состоит классификационная метка?
# 2. На каталог установлен уровень конфиденциальности 2 Пользователь вошел в систему с уровнем 2 и собирается создать внутри этого каталога файл с уровнем конфиденциальности 1 Удастся ли это сделать?
# 3. Какие утилиты можно использовать для назначения возможных мандатных
# уровней учетным записям пользователей?
