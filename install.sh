#!/bin/bash
#winpty "docker.exe" "$@"
#alias docker="winpty docker"
docker pull kalilinux/kali-rolling;
winpty docker run -it --name kalilinux kalilinux/kali-rolling bash -c "apt update && apt -y full-upgrade && apt auto-remove && apt auto-clean" &&
docker start kalilinux &&
winpty docker exec -it kalilinux bash -c "apt-get -y install lsof ruby metasploit-framework" &&
winpty docker exec -it kalilinux bash -c "grep -ril 'systemctl status \${PG_SERVICE}' /usr/bin/msfdb | xargs sed -i -e 's/systemctl status \${PG_SERVICE}/\/etc\/init.d\/\${PG_SERVICE} status/g'" &&
winpty docker exec -it kalilinux bash -c "grep -ril 'systemctl --no-pager -l status \${PG_SERVICE}' /usr/bin/msfdb | xargs sed -i -e 's/systemctl --no-pager -l status \${PG_SERVICE}/\/etc\/init.d\/\${PG_SERVICE} status/g'" &&
winpty docker exec -it kalilinux bash -c "grep -ril 'systemctl stop \${PG_SERVICE}' /usr/bin/msfdb | xargs sed -i -e 's/systemctl stop \${PG_SERVICE}/\/etc\/init.d\/\${PG_SERVICE} stop/g'" &&
winpty docker exec -it kalilinux bash -c "grep -ril 'systemctl start \${PG_SERVICE}' /usr/bin/msfdb | xargs sed -i -e 's/systemctl start \${PG_SERVICE}/\/etc\/init.d\/\${PG_SERVICE} start/g'" &&
winpty docker exec -it kalilinux bash -c "msfdb init" &&
winpty docker exec -it kalilinux bash -c "msfdb run" &&
winpty docker exec -it kalilinux bash -c "exit"
