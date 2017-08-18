FROM bconnect/phing
COPY runner.sh /runner.sh
CMD ["/runner.sh"]
