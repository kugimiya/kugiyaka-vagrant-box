Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.33.12"

  config.vm.synced_folder "../Projects/sources/parus", "/var/www/html", type: "rsync", 
    rsync__exclude: [".git/", "assets/node_modules", "vendor"],
    rsync__args: ["--verbose", "--rsync-path='sudo rsync'", "--archive", "-z"]

  config.vm.synced_folder "./sites-enabled", "/etc/nginx/sites-enabled", type: "rsync"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3072"
    vb.cpus = 8
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt update
    apt upgrade -yyq
    curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    apt install -yyq nginx git curl unzip mysql-server-5.7 php-fpm php-mysql php-mbstring php-xml composer nodejs build-essential
    ufw allow 'Nginx HTTP'
    ufw status
    ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
    curl -4 icanhazip.com
    rm /etc/nginx/sites-enabled/default
    service nginx restart
  SHELL
end
