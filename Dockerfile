FROM node

COPY config/* /etc/skel/
COPY scripts/* /usr/local/bin/
RUN /usr/local/bin/provision.sh

USER jab
WORKDIR /code
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["gulp"]