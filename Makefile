.SECONDEXPANSION: 


PROCESSING_SCRIPT=/usr/share/judo/preprocess.py
# The root-directory where to look for datasets.
DATASETS=$(wildcard data/*)


data: $(DATASETS)

# A dataset has the following dependencies:
# The file-structure has to exist ('original' and 'preprocessed'-directories).
# For each original file, a preprocessed one has to exist. (original/train.csv -> preprocessed/train.csv).
$(DATASETS): $$@/original $$(subst original,preprocessed,$$(wildcard $$@/original/*.csv))

# Only gets executed if the local "/original" subdirectory does not exist.
%/original:
	@echo ""
	$(call create_initial_file_structure,$(subst /original,,$@))

# Only gets executed if no preprocessed files corresponding to the originals exist.
data/%$(wildcard preprocessed/*.csv):
	$(call preprocess_data,$@)


define create_initial_file_structure
	@echo "Creating filestructure for $(1) ..."
	mkdir $(1)/original
	mkdir $(1)/preprocessed
	cp $(PROCESSING_SCRIPT) $(1)/preprocess.py
endef

define preprocess_data
	@echo "Processing $(1) ..."
	@# Construct the corresponding original-file path.
	$(eval original_path:=$(subst preprocessed,original,$(1)))
	@# Construct the path to the script, which transforms original files to preprocessed files.
	@# This resides in each project-directory, since this is project-specific.
	$(eval dataset_root_path := $(shell echo $(1) | rev | cut -d'/' -f 3- | rev))
	@python $(dataset_root_path)/preprocess.py $(original_path) $(1)
endef


.PHONY: $(DATASETS) 
