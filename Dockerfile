FROM bconnect/phing
COPY runner.sh /runner.sh
ADD build.xml /build.xml
CMD ["/runner.sh"]
