FROM docker.elastic.co/logstash/logstash:6.1.2
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
RUN rm -rf /usr/share/logstash/patterns.d
COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf
RUN mkdir /usr/share/logstash/patterns.d
COPY apache-error /usr/share/logstash/patterns.d/apache-error
#ADD pipeline/ /usr/share/logstash/pipeline/
#ADD config/ /usr/share/logstash/config/
