PLUGIN_NAME=judo-datasets

install:
	cp -rp . /usr/local/share/judo/plugins/$(PLUGIN_NAME)

uninstall:
	rm -r /usr/local/share/judo/plugins/$(PLUGIN_NAME)
