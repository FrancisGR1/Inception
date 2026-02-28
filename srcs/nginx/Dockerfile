FROM alpine:3.22

RUN apk --no-cache add \
	    vim \
	    nginx \
	    openssl

RUN mkdir /etc/nginx/ssl

# create RSA key and save it
RUN openssl req \
	    -newkey rsa:4096 \
	    -x509 \
	    -sha256 \
	    -days 365 \
	    -nodes \
	    -out /etc/nginx/ssl/public_key.crt \
	    -keyout /etc/nginx/ssl/private_key.key \
	    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 School/OU=frmiguel/CN=frmiguel.42.fr"

COPY nginx.conf /etc/nginx/http.d/wordpress.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
