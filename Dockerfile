FROM ubuntu:18.04

ENV USER csgo
ENV HOME /home/$USER
ENV SERVER $HOME/hlserver

ENV SV_PASSWORD notleakpls
ENV RCON dontleakpls

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc1 wget unzip git curl net-tools lib32stdc++6 locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd $USER \
    && mkdir $HOME \
    && chown $USER:$USER $HOME \
    && mkdir $SERVER

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ADD ./csgo_ds.txt $SERVER/csgo_ds.txt
ADD ./update.sh $SERVER/update.sh
ADD ./server.cfg $SERVER/csgo/csgo/cfg/server.cfg
ADD ./csgo.sh $SERVER/csgo.sh

RUN chmod 777 $SERVER/csgo.sh
RUN chmod 777 $SERVER/update.sh

RUN mkdir /home/get5
RUN cd /home/get5
RUN wget https://github.com/splewis/get5/releases/download/0.7.1/get5_0.7.1.zip
RUN unzip get5_0.7.1.zip

RUN chown -R $USER:$USER $SERVER

USER $USER
RUN curl http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz \
    && $SERVER/update.sh

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