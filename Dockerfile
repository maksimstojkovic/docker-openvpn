# Smallest base image (modified for stability)
FROM alpine:3.8

ARG VCS_REF

LABEL maintainer="Maksim Stojkovic <https://github.com/silentdigit>" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/silentdigit/docker-openvpn"

# Testing: pamtester
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --no-cache openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

# Prevents refused client connection because of an expired CRL
ENV EASYRSA_CRL_DAYS 3650

VOLUME ["/etc/openvpn"]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/ucp`
EXPOSE 1194/udp

CMD ["ovpn_run"]

COPY ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Add support for OTP authentication using a PAM module
ADD ./otp/openvpn /etc/pam.d/
