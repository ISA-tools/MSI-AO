OBO=http://purl.obolibrary.org/obo
ONT=MSIO
BASE=$(OBO)/$(ONT)
SRC=$(ONT)-edit.owl
RELEASEDIR=./releases
IMPORTSDIR=./imports
ROBOT-PLUS=robot-plus
GRADLE=gradle

all: $(ONT).owl

test:all

prepare_release:
	$(GRADLE) clean
	$(GRADLE) jar
	cp ./build/libs/robot-plus.jar ./bin/
	export PATH=$(PATH):$(PWD)/bin

	$(ROBOT-PLUS) merge  -I "http://purl.obolibrary.org/obo/duo.owl" extract --method MIREOT \
	          --upper-term "owl:Thing" --lower-term "obo:DUO_0000001" --lower-term "obo:DUO_0000017" \
	          --branch-from-term "obo:DUO_0000001" --branch-from-term "obo:DUO_0000017" \
	          --output $(IMPORTSDIR)/duo_import.owl
