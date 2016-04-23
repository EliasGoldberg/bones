yum -y install wget
wget -c -O jre-8u60-linux-x64.rpm –nv -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jre-8u91-linux-x64.rpm
chmod a+x jre-8u60-linux-x64.rpm
rpm -ivh jre-8u60-linux-x64.rpm
