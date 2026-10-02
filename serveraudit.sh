{
s(){ echo; echo "===== $* ====="; }
s OS; grep -E '^(PRETTY_NAME|VERSION_ID)=' /etc/os-release; uname -r
s RESOURCES; echo "cpus: $(nproc)"; free -h; df -hT -x tmpfs -x devtmpfs; uptime
s SELINUX; getenforce 2>/dev/null || echo n/a
s LISTENING_PORTS; ss -ltnpH | awk '{print $4, $6}' | sort -u
s RUNNING_SERVICES; systemctl list-units --type=service --state=running --no-pager --no-legend | awk '{print $1}'
s PANELS; ls -d /usr/local/cpanel /usr/local/psa /usr/local/CyberCP /www/server/panel /usr/local/hestia /usr/local/directadmin /etc/webmin /usr/local/lsws 2>/dev/null || echo none
s WEB_SERVERS; nginx -v 2>&1 | head -1; (httpd -v || apache2 -v) 2>/dev/null | head -1; caddy version 2>/dev/null
s NGINX_VHOSTS; nginx -T 2>/dev/null | grep -E '^# configuration file|^[[:space:]]*(listen|server_name|proxy_pass)[[:space:]]'
s APACHE_VHOSTS; (httpd -S || apache2ctl -S) 2>/dev/null | head -40
s POSTGRES_PACKAGES; ls -d /usr/pgsql-*/ /usr/lib/postgresql/*/ 2>/dev/null; rpm -qa 'postgresql*' 2>/dev/null | sort; dpkg -l 'postgresql*' 2>/dev/null | awk '/^ii/{print $2,$3}'
s POSTGRES_LIVE; (cd / && runuser -u postgres -- psql -AtqX -c "select version()" -c "show port" -c "show listen_addresses" -c "show password_encryption" -c "show hba_file" -c "select 'db: '||datname from pg_database where not datistemplate" -c "select 'role: '||rolname from pg_roles where rolcanlogin") 2>&1
s PG_HBA; f=$(cd / && runuser -u postgres -- psql -AtqXc 'show hba_file' 2>/dev/null); [ -n "$f" ] && grep -vE '^[[:space:]]*(#|$)' "$f"
s MYSQL; (mysql --version || mariadb --version) 2>/dev/null || echo none
s RUNTIMES; ruby -v 2>/dev/null || echo "ruby: none"; ls -d /usr/local/rvm /root/.rbenv /root/.rvm 2>/dev/null; node -v 2>/dev/null || echo "node: not in root PATH"; pm2 list 2>/dev/null; docker ps --format '{{.Names}} {{.Ports}}' 2>/dev/null
s REDMINE_EXISTING; id redmine 2>&1; ls -ld /opt/redmine /etc/systemd/system/redmine.service 2>&1
s BUILD_PACKAGES; rpm -q gcc make openssl openssl-libs openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel libpq-devel epel-release 2>/dev/null
s PENDING_OPENSSL_UPDATE; dnf -q check-update openssl openssl-libs 2>/dev/null; echo "exit=$? (100 = update pending)"
s REPOS; dnf -q repolist 2>/dev/null; dnf -q module list --enabled 2>/dev/null | grep -Ei 'postgres|ruby|nginx|nodejs'
s CERTS; certbot certificates 2>/dev/null | grep -E 'Certificate Name|Domains|Expiry'; ls -d /root/.acme.sh 2>/dev/null
s FIREWALL; for u in firewalld ufw nftables csf lfd fail2ban crowdsec; do echo "$u: $(systemctl is-active $u 2>/dev/null)"; done; firewall-cmd --list-all 2>/dev/null
s DNS; echo "pm.netaport.com -> $(getent ahosts pm.netaport.com | awk 'NR==1{print $1}')"; echo "server public IP -> $(curl -s4 -m 5 ifconfig.me)"
} 2>&1 | tee /root/server-audit.txt
