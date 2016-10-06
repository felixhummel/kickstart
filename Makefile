# https://help.ubuntu.com/lts/installation-guide/amd64/ch04s06.html
ROOT_PW_ENC := $(shell python3 -c 'import crypt; print(crypt.crypt("toor"))')
KICKSTART_CONFIG_URL := http://$(shell hostname -f):9080/ks.cfg
# empty, if no key exists (which is what we want)
SSH_PUBKEY := $(shell cat $$HOME/.ssh/id_rsa.pub 2>/dev/null)

default: ubuntu-16.04.1-server-amd64-ks.iso

ks.cfg:
	sed -e 's;MY_PUBKEY;$(SSH_PUBKEY);' -e 's;ROOT_PW_ENC;$(ROOT_PW_ENC);' ks.cfg.tmpl > ks.cfg

ubuntu-16.04.1-server-amd64.iso:
	#wget 'http://releases.ubuntu.com/16.04/ubuntu-16.04.1-server-amd64.iso'
	md5sum -c MD5SUMS

target: ubuntu-16.04.1-server-amd64.iso
	mkdir -p source
	sudo mount -o loop ubuntu-16.04.1-server-amd64.iso source
	sudo cp -rT source target
	sudo umount source

target/isolinux/txt.cfg: target
	sed -e 's;KICKSTART_CONFIG_URL;$(KICKSTART_CONFIG_URL);' txt.cfg.tmpl > txt.cfg
	sudo cp txt.cfg target/isolinux/txt.cfg
	sudo chmod 444 target/isolinux/txt.cfg

target/isolinux/isolinux.cfg: target
	sudo cp isolinux.cfg target/isolinux/isolinux.cfg
	sudo chmod 444 target/isolinux/isolinux.cfg

ubuntu-16.04.1-server-amd64-ks.iso: target/isolinux/txt.cfg target/isolinux/isolinux.cfg ks.cfg
	sudo mkisofs -J -l -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -z -iso-level 4 -c isolinux/isolinux.cat -o ubuntu-16.04.1-server-amd64-ks.iso -joliet-long target/
	sudo chown $(shell id -u):$(shell id -g) ubuntu-16.04.1-server-amd64-ks.iso

.PHONY: clean
clean:
	sudo rm -rf target/
	rm -f ks.cfg
	rm -f txt.cfg
	rm -f ubuntu-16.04.1-server-amd64-ks.iso

.PHONY: ssh
ssh:
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 9122 root@localhost

# how to generate a ks.cfg
.PHONY: deps
deps:
	sudo apt-get -y install system-config-kickstart
	system-config-kickstart

