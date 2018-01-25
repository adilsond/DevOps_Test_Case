FROM jenkins/jenkins:lts
# Jump setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
#Copy pre-configured settings
COPY --chown=1000:1000 config.xml /var/jenkins_home
COPY --chown=1000:1000 jenkins.CLI.xml /var/jenkins_home
#Copy jenkins_admin user - See README for default user and password
COPY --chown=1000:1000 ./users/ /var/jenkins_home/users/
#Copy script file
COPY --chown=1000:1000 ./scripts /var/jenkins_home/scripts
#Copy job folder
COPY --chown=1000:1000 ./jobs/ /var/jenkins_home/jobs/
# install plugins
COPY --chown=1000:1000 plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

