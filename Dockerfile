#For CentOS 7
FROM centos:7.4.1708

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
COPY nginx-repo.crt nginx-repo.key /etc/ssl/nginx/

# Install prerequisite packages
RUN yum -y install wget ca-certificates epel-release

# Add NGINX Plus repo to yum
RUN wget -P /etc/yum.repos.d https://cs.nginx.com/static/files/nginx-plus-7.repo
RUN wget -P /etc/yum.repos.d https://cs.nginx.com/static/files/app-protect-signatures-7.repo
# Install NGINX App Protect
RUN yum -y install app-protect app-protect-attack-signatures \
    && yum clean all \
    && rm -rf /var/cache/yum 
#    && rm -rf /etc/ssl/nginx

# Forward request logs to Docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#    && ln -sf /dev/stderr /var/log/nginx/error.log
    
# Copy configuration files  
RUN rm /etc/nginx/conf.d/default.conf
COPY etc/nginx/* /etc/nginx/
COPY entrypoint.sh  ./

EXPOSE 80
CMD ["sh", "/entrypoint.sh"] 
