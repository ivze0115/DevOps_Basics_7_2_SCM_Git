Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  # web1
  config.vm.define "web1" do |web1|
    web1.vm.hostname = "web1"
    web1.vm.network "private_network", ip: "192.168.56.11"
    web1.vm.provider "virtualbox" do |vb|
      vb.name = "web1"
      vb.memory = 512
      vb.cpus = 1
    end
  end

  # web2
  config.vm.define "web2" do |web2|
    web2.vm.hostname = "web2"
    web2.vm.network "private_network", ip: "192.168.56.12"
    web2.vm.provider "virtualbox" do |vb|
      vb.name = "web2"
      vb.memory = 512
      vb.cpus = 1
    end
  end

  # db
  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.13"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "db"
      vb.memory = 512
      vb.cpus = 2
    end
  end

end

