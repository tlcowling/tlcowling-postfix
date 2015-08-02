# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  systems = {
    trusty64: "puppetlabs/ubuntu-14.04-64-puppet",
    precise64: "puppetlabs/ubuntu-12.04-64-puppet",
    debian7: "puppetlabs/debian-7.8-64-puppet",
    centos7: "puppetlabs/centos-7.0-64-puppet",
    centos6: "puppetlabs/centos-6.6-64-puppet",
    centos5: "puppetlabs/centos-5.11-64-puppet"
  }

  systems.each do |os, box|
    config.vm.define os do |machine|
      machine.vm.box = box
      machine.vm.synced_folder "./test/modules", "/etc/puppet/modules/"
      machine.vm.synced_folder "./", "/etc/puppet/modules/postfix/"
      machine.vm.provision "shell" do |s|
        s.inline = "/opt/puppetlabs/bin/puppet apply --modulepath=/etc/puppet/modules --hiera_config=/vagrant/test/hiera.yaml /vagrant/test/init.pp"
      end
    end
  end
end
