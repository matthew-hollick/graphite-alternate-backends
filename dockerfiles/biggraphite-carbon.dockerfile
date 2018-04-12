FROM my_bg_init

EXPOSE 2003-2004 7002
VOLUME ["/opt/graphite/conf", "/var/log"]
WORKDIR /
ENV HOME /root
ENV PYTHONPATH /opt/graphite/lib/
VOLUME ["/shared", "/opt/graphite/conf"] 
CMD /opt/graphite/conf/init.sh