INCLUDE=-I +cairo
LINK=--mllopt cairo.cmxa
OPB=opa-plugin-builder
OPA=opa $(OPAOPT)

all: opawhiteboard.exe

cairo.opp: src/cairo.ml
	$(OPB) $(INCLUDE) src/cairo.ml -o cairo

opawhiteboard.exe: cairo.opp
	$(OPA) $(INCLUDE) $(LINK) cairo.opp src/buffer.opa src/client.opa src/main.opa -o opawhiteboard.exe

clean:
	rm -Rf *.exe _build _tracks *.log *.opp
