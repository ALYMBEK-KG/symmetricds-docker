FROM jumpmind/symmetricds:3.15.12
WORKDIR /opt/symmetric-ds
COPY . ./engines

ARG APP_NAME

RUN bin/symadmin --engine $APP_NAME uninstall &&\
    bin/symadmin --engine $APP_NAME create-sym-tables &&\
    bin/dbimport --engine $APP_NAME engines/insert.sql

VOLUME ["/opt/symmetric-app"]
EXPOSE 31415
ENTRYPOINT ["bin/sym"]
