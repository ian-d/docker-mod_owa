FROM httpd:2.4
MAINTAINER "Ian Dillon <dillon@etsu.edu>"

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include
ENV TNS_ADMIN=/opt/oracle/instantclient

# INSTALL TOOLS
RUN apt-get update \
    && apt-get -y --no-install-recommends install unzip \
    libaio-dev \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt/oracle \
    && wget -q --no-check-certificate https://internal.etsu.edu/dockermedia/oracle_client/instantclient-basic-linux.x64-12.1.0.2.0.zip \
    && wget -q --no-check-certificate https://internal.etsu.edu/dockermedia/oracle_client/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && rm instantclient*.zip \
    && mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient \
    && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so.11.1

RUN echo "LoadModule owa_module modules/mod_owa.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "Include conf/dads.conf" >> /usr/local/apache2/conf/httpd.conf

ADD mod_owa.so /usr/local/apache2/modules/
ADD dads.conf /usr/local/apache2/conf/
ADD tnsnames.ora /opt/oracle/instantclient
