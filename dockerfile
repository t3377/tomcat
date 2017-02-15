FROM ubuntu

# add java REPO
RUN apt-get update && apt-get install -y curl \
  python-software-properties \
  software-properties-common \
  && add-apt-repository ppa:webupd8team/java
  
# Install Java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle license-v1-1 see true | debconf-set-selections \
 && apt-get update && apt-get -y install oracle-java7-installer

# Install Tomcat
RUN mkdir -p /opt/tomcat \
 && curl -SL http://apache.fastbull.org/tomcat-7/v7.0.72/bin/apache-tomcat-7.0.72.tar.gz \
 | tar -xzC /opt/tomcat --strip-components=1 \
 && rm -RF /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples
 
# Expose tomcat
EXPOSE 8080

ENV JAVA_OPT -server -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC \
  -Xms1G -Xmx2G -xx:PermSize=1G -XX:MaxPermSize=2G
  
workdir /OPT/Tomcatcmd ["bin/catalina.sh","run"]  
