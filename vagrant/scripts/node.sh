yum install -y git
wget -q https://nodejs.org/dist/v4.4.4/node-v4.4.4.tar.gz
mkdir node
tar xf node-v*.tar.gz --strip-components=1 -C ./node
rm -rf node-v*
mkdir node/etc
echo 'prefix=/usr/local' > node/etc/npmrc
mv node /opt/
chown -R root: /opt/node
ln -s /opt/node/bin/node /usr/local/bin/node
ln -s /opt/node/bin/npm /usr/local/bin/npm
