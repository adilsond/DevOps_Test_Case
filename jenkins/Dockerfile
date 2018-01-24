FROM jenkins/jenkins:lts
# Jump setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
#Copy pre-configured settings
COPY --chown=1000:1000 config.xml /var/jenkins_home
COPY --chown=1000:1000 jenkins.CLI.xml /var/jenkins_home
#Copy jenkins_admin user - See README for default user and password
COPY --chown=1000:1000 ./jenkins_admin /var/jenkins_home/users/jenkins_admin
#Copy script file
COPY --chown=1000:1000 ./scripts /var/jenkins_home/scripts
#Copy job folder
COPY --chown=1000:1000 Clean_Index /var/jenkins_home/jobs/Clean_Index
# install plugins
COPY --chown=1000:1000 plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

