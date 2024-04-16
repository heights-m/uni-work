TGT = hello.out
CMIS = amodule.cmi
CMOS = amodule.cmo bmodule.cmo 

RM = rm
TRUE = true

.SUFFIXES:
.SUFFIXES: .cmi .cmo .mli .ml

.mli.cmi:; ocamlc -c $< -o $@
.ml.cmo:; ocamlc -c $< -o $@

$(TGT): $(CMIS) $(CMOS)
	ocamlc -o $@ $(CMOS)

clean:
	$(RM) *.cmi | $(TRUE)
	$(RM) *.cmo | $(TRUE)
