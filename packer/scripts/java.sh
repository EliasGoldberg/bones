yum -y install wget
wget --no-check-certificate -c -q --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm
chmod a+x jdk-8u91-linux-x64.rpm
rpm -ivh jdk-8u91-linux-x64.rpm
