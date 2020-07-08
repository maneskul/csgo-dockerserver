## CSGO Server in Docker

CS:GO server in docker with 128 tick enabled by default.

Based on [Gonzih](https://github.com/Gonzih/docker-csgo-server/) project.


### Docker hub image

```shell
docker pull maneskul/csgo-dockerserver
```

### Running public server

To run public server you need to [Register Login Token](http://steamcommunity.com/dev/managegameservers) and adding `+sv_setsteamaccount THISGSLTHERE -net_port_try 1` to the server command.
Refer to [Docs](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Registering_Game_Server_Login_Token) for more details.