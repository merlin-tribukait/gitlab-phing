FROM bconnect/phing
COPY runner.sh /runner.sh
ADD build.xml /build.xml
ADD ssh_config /etc/ssh/ssh_config
CMD ["/runner.sh"]
