# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "cal" do |cal|
    cal.vm.box = "hashicorp/precise32"
    cal.vm.provision :shell, path: "bootstrap_cal.sh"
    cal.vm.network "public_network"
  end

  config.vm.define "dimarco" do |dimarco|
    dimarco.vm.box = "hashicorp/precise32"
    dimarco.vm.provision :shell, path: "bootstrap_dimarco.sh"
  end
end
