groupadd -g $GID dockeru
useradd -u $UID -g $GID -m -s /bin/zsh dockeru
chown -R dockeru:dockeru /home/dockeru
exec $@

