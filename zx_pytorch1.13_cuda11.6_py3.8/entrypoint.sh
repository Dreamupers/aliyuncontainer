echo 'export PATH=/home/dockeru/.local/bin:$PATH' >> /home/dockeru/.zshrc
usermod -u $UID dockeru 
groupmod -g $GID dockeru
# chown -R dockeru:dockeru /home/dockeru
find /home/dockeru -group 1000 -exec chgrp -h dockeru {} \;
cd /home/dockeru
echo "{\"editor.fontSize\": 18,\"workbench.colorTheme\": \"GitHub Light\"}" >> /home/dockeru/.local/share/code-server/User/settings.json
echo "{\"locale\": \"zh-cn\"}" >> /home/dockeru/.local/share/code-server/User/argv.json
chown dockeru:dockeru /home/dockeru/.local/share/code-server/User/settings.json
chown dockeru:dockeru /home/dockeru/.local/share/code-server/User/argv.json
exec gosu dockeru code-server --host 0.0.0.0