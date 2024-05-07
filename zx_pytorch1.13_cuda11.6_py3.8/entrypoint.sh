usermod -u $UID dockeru 
groupmod -g $GID dockeru
cd /home/dockeru
exec gosu dockeru $@