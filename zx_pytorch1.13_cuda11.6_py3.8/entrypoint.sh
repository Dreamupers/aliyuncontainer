echo 'export PATH=/home/dockeru/.local/bin:$PATH' >> /home/dockeru/.zshrc
usermod -u $UID dockeru 
groupmod -g $GID dockeru
# chown -R dockeru:dockeru /home/dockeru
find /home/dockeru -group 1000 -exec chgrp -h dockeru {} \;
cd /home/dockeru
exec gosu dockeru code-server --host 0.0.0.0