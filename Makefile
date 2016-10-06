# https://help.ubuntu.com/lts/installation-guide/i386/ch04s06.html
.PHONY: deps
deps:
	sudo apt-get -y install system-config-kickstart

ks.cfg:
	system-config-kickstart --generate ks.cfg

ROOT_PW := beif1Tiepao4oov2
rootpw:
	python -c 'import crypt; print(crypt.crypt("$(ROOT_PW)"))' > rootpw
