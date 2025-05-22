FROM nginx:alpine

# Instala bash y crea un script para mostrar las variables de entorno
RUN <<EOF
apk add --no-cache bash

# create script to show environment variables
echo '#!/bin/bash' > /entrypoint.sh && \
echo 'echo "<html><body><h1>Variables de Entorno</h1><pre>" > /usr/share/nginx/html/index.html' >> /entrypoint.sh && \
echo 'printenv >> /usr/share/nginx/html/index.html' >> /entrypoint.sh && \
echo 'echo "</pre></body></html>" >> /usr/share/nginx/html/index.html' >> /entrypoint.sh && \
echo 'nginx -g "daemon off;"' >> /entrypoint.sh && chmod +x /entrypoint.sh

EOF

# Exponer el puerto 80
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]  
