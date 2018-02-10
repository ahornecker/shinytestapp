FROM drhornecker/shinybase

MAINTAINER Achim Hornecker "achim@hornecker.de"

# copy the app to the image
RUN mkdir /root/app
COPY app /root/app

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/app')"]
