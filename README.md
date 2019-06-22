# mono-ubuntu1804
mono with screen based on ubuntu 18.04 (for run opensim on mono). it will put opensim to screen as setup in /opt/opensim/bin/autostart.sh 

Usages :
<pre># docker run -d -v /host/part/to/opensim/:/opt/opensim/  dockuru101/mono-ubuntu1804:5.20.1.19-2 </pre>

After run the container, you can access opensim console by :
<pre> # docker exec -it container-id /bin/bash </pre>
then this command : 
<pre> screen -r</pre>

You can detach from opensim console by ctrl+a+d and exit bash by "exit" command.

Or to stop container use "quit" command in opensim console.

Example of /opt/opensim/autostart.sh :
<pre>#!/bin/sh
### make sure this file is chmod +x 
cd /opt/opensim/bin/
rm *.log
screen -DmS opensim mono ./OpenSim.exe </pre>


Dockerfile :
<pre>FROM ubuntu:18.04

RUN echo America/Los_Angeles > /etc/timezone \
    && rm -f /etc/localtime \
    && ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

RUN apt-get update && apt-get install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/ubuntu bionic main" | tee /etc/apt/sources.list.d/mono-official.list
RUN apt-get update && apt-get install -y -q screen mono-complete ca-certificates-mono  \
           && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 8002/tcp 8008/tcp 9000/tcp 9001/tcp 9002/tcp 9003/tcp
EXPOSE 9000/udp 9001/udp 9002/udp 9003/udp
WORKDIR /opt/opensim/bin

CMD [ "./autostart.sh" ]</pre>
