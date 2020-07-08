FROM gonzih/csgo-server

ENV SV_PASSWORD notleakpls
ENV RCON dontleakpls
ENV STEAM_ACC 42A3396D91902FBC7B8B9923D1FA5AAC

USER root
RUN mkdir -p /home/get5
RUN chown $USER /home/get5
RUN cd /home/get5

RUN apt-get -y update \
    && apt-get install -y wget unzip \
    && wget https://github.com/splewis/get5/releases/download/0.7.1/get5_0.7.1.zip \
    && unzip get5_0.7.1.zip

RUN cp -RT /home/get5/ $SERVER/csgo/addons/

USER $USER

ADD ./autoexec.cfg $SERVER/csgo/csgo/cfg/autoexec.cfg
ADD ./server.cfg $SERVER/csgo/csgo/cfg/server.cfg
ADD ./csgo.sh $SERVER/csgo.sh

USER root
RUN mkdir ~/.steam/sdk32/
RUN ln -s ~/hlserver/linux32/steamclient.so /home/csgo/.steam/sdk32/steamclient.so
RUN chown $USER /home/csgo/.steam/sdk32/steamclient.so
RUN chown $USER $SERVER/csgo/csgo/cfg/server.cfg
RUN chown $USER $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN rm -rf /home/get5
USER $USER

EXPOSE 27015
EXPOSE 27015/udp

EXPOSE 27024
EXPOSE 27024/udp

WORKDIR /home/$USER/hlserver
ENTRYPOINT ["./csgo.sh"]
CMD ["-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]
