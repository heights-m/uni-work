# Makefile
TGT  = app
HSRC = common.h refobj.h complex.h rect.h polar.h vector3.h
OBJS = common.o refobj.o complex.o rect.o polar.o vector3.o app.o

RM   = rm
TRUE = true

.SUFFIXES:          # reset all suffixes
.SUFFIXES: .c .o	# suffixes to consider

# convert .c to .o
.c.o:; gcc -c $< -o $@	

$(TGT): $(HSRC) $(OBJS)
	gcc -o $@ $(OBJS) -lm -g

clean:
	$(RM) *.o | $(TRUE)

