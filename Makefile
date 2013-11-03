PACKAGES=-package sdl.sdlmixer,core,async

all: test

types: ./lib/types.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/types.ml

rational: types ./lib/rational.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/rational.ml

tone: rational types ./lib/tone.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/tone.ml

sound: tone ./lib/sound.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/sound.ml

schedule: sound ./lib/schedule.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/schedule.ml

test: schedule ./lib_test/test.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib_test/test.ml
	ocamlfind ocamlopt -o lib_test/test $(PACKAGES) -linkpkg -thread ./lib/types.cmx ./lib/rational.cmx ./lib/tone.cmx ./lib/sound.cmx ./lib/schedule.cmx ./lib_test/test.cmx

clean:
	rm ./lib*/*.cm*
	rm ./lib*/*o
	rm ./lib_test/test
