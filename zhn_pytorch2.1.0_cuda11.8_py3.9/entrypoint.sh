echo 'export PATH=/home/dockeru/.local/bin:$PATH' >> /home/dockeru/.zshrc
usermod -u $UID dockeru 
groupmod -g $GID dockeru
chown -R dockeru:dockeru /home/dockeru
cd /home/dockeru
exec gosu dockeru $@