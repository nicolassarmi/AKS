# Instalar servidor de shiny con rocker
FROM rocker/shiny-verse:3.5.0

RUN apt-get update && apt-get install libcurl4-openssl-dev libv8-3.14-dev -y &&\
  mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Bajar e instalar las librerías de R
RUN R -e "install.packages(c('shinythemes', 'DT', 'shinydashboard', 'shinyjs', 'V8', 'ggrepel'))"

# Copiar la app a la imagen

COPY . /srv/shiny-server/

# Copiar configuración del servidor shiny
#COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf

# Hacer todas las apps leíbles (solves issue when dev in Windows, but building in Ubuntu)
RUN chmod -R 755 /srv/shiny-server/


# Indicar el puerto disponible para shiny
EXPOSE 3838

# Copiar donde poner los logfiles
COPY shiny-server.sh /usr/bin/shiny-server.sh

# Correr la aplicación
#CMD ["/usr/bin/shiny-server.sh"] 
CMD ["chmod", "+x", "/usr/bin/shiny-server.sh"]
