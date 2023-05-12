.SECONDEXPANSION: 


PROCESSING_SCRIPT='$(PWD)/.datasets/preprocess.py'
# The root-directory where to look for datasets.
ROOT=data
DATASETS=$(wildcard $(ROOT)/*)


datasets: $(DATASETS) | $(ROOT)

$(ROOT):
	mkdir $(ROOT)

# A dataset has the following dependencies:
# The file-structure has to exist ('original' and 'preprocessed'-directories).
# For each original file, a preprocessed one has to exist. (original/train.csv -> preprocessed/train.csv).
$(DATASETS): $$@/original $$(call do_originals_exist,$$@) $$(subst $$@/original,$$@/preprocessed,$$(wildcard $$@/original/*))

# Only gets executed if the local "/original" subdirectory does not exist.
%/original:
	@echo ""
	$(call create_initial_file_structure,$(@D))

# Only gets executed if no raw files exist.
$(ROOT)/%/get_original_data:
	@echo "No raw files exist. Retrieving ..."
	@cd $(@D) && sh get_original_data.sh
	
# Only gets executed if no preprocessed files corresponding to the originals exist.
$(ROOT)/%$(wildcard preprocessed/*):
	$(call preprocess_data,$@)


define create_initial_file_structure
	@echo "Creating filestructure for $(1) ..."
	mkdir $(1)/original
	mkdir $(1)/preprocessed
	cp $(PROCESSING_SCRIPT) $(1)/preprocess.py
	touch $(1)/get_original_data.sh
endef

define do_originals_exist
	$(shell [[ $$(ls -A $(1)/original 2> /dev/null | wc -l) -gt 0 ]] || echo '$(1)/get_original_data')
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
