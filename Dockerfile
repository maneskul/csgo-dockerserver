FROM gonzih/csgo-server

ENV SV_PASSWORD notleakpls
ENV RCON dontleakpls

RUN mkdir /home/get5
RUN cd /home/get5
RUN wget https://github.com/splewis/get5/releases/download/0.7.1/get5_0.7.1.zip
RUN unzip get5_0.7.1.zip

RUN cp -RT /home/get5/ $SERVER/csgo/addons/

RUN echo 'log on' > $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN echo 'hostname "CSGO Server"' >> $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN echo 'sv_cheats 0' >> $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN echo 'sv_lan 0"' >> $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN echo 'rcon_password "$RCON"' >> $SERVER/csgo/csgo/cfg/autoexec.cfg
RUN echo 'sv_password "$SV_PASSWORD"' >> $SERVER/csgo/csgo/cfg/autoexec.cfg

EXPOSE 27015
EXPOSE 27015/udp

EXPOSE 27024
EXPOSE 27024/udp

WORKDIR /home/$USER/hlserver
ENTRYPOINT ["./csgo.sh"]
CMD ["-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_dust2"]