# https://help.ubuntu.com/lts/installation-guide/i386/ch04s06.html
.PHONY: deps
deps:
	sudo apt-get -y install system-config-kickstart

ks.cfg:
	system-config-kickstart --generate ks.cfg

# TODO change me!
ROOT_PW := toor
rootpw:
	python -c 'import crypt; print(crypt.crypt("$(ROOT_PW)"))' > rootpw

.PHONY: copy_iso
copy_iso:
	mkdir -p source
	sudo mount -o loop /home/felix/isos/ubuntu-16.04.1-server-amd64.iso source
	sudo cp -rT source target
	sudo umount source

.PHONY: update_isolinux
update_isolinux:
	sudo cp txt.cfg target/isolinux/txt.cfg
	sudo chmod 444 target/isolinux/txt.cfg
	sudo cp isolinux.cfg target/isolinux/isolinux.cfg
	sudo chmod 444 target/isolinux/isolinux.cfg

ubuntu-16.04.1-server-amd64-ks.iso:
	sudo mkisofs -J -l -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -z -iso-level 4 -c isolinux/isolinux.cat -o ubuntu-16.04.1-server-amd64-ks.iso -joliet-long target/
	sudo chown $(shell id -u):$(shell id -g) ubuntu-16.04.1-server-amd64-ks.iso

.PHONY: clean
clean:
	rm ubuntu-16.04.1-server-amd64-ks.iso
