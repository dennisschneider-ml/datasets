PLUGIN_NAME=judo-datasets

install:
	mkdir -p ${HOME}/.config/judo/plugins/$(PLUGIN_NAME)
	cp -r . ${HOME}/.config/judo/plugins/$(PLUGIN_NAME)
	chmod 777 -R ${HOME}/.config/judo/plugins  ${HOME}/.config/judo/plugins/$(PLUGIN_NAME)

uninstall:
	rm -r ${HOME}/.config/judo/plugins/$(PLUGIN_NAME)
