PACKAGES=-package sdl.sdlmixer,core

all: test

pitch: ./lib/pitch.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/pitch.ml

tone: pitch ./lib/tone.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/tone.ml

sound: tone ./lib/sound.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib/sound.ml

test: sound ./lib_test/test.ml
	ocamlfind ocamlopt $(PACKAGES) -thread -I ./lib -c ./lib_test/test.ml
	ocamlfind ocamlopt -o lib_test/test $(PACKAGES) -linkpkg -thread ./lib/pitch.cmx ./lib/tone.cmx ./lib/sound.cmx ./lib_test/test.cmx

clean:
	rm ./lib*/*.cm*
	rm ./lib*/*o
	rm ./lib_test/test
