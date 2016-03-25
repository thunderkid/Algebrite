# The symbol table is a simple array of struct U.

#include "stdafx.h"
#include "defs.h"

# put symbol at index n

# s is a string, n is an int
std_symbol = (s, n) ->
	p = symtab[n]
	if !p?
		debugger
	p.printname = s

# symbol lookup, create symbol if need be

# s is a string
usr_symbol = (s) ->
	for i in [0...NSYM]
		if (symtab[i].printname == 0)
			break
		if (s == symtab[i].printname)
			return symtab[i]
	if (i == NSYM)
		stop("symbol table overflow")
	p = symtab[i]
	p.printname = s
	return p

# get the symbol's printname

# p is a U
get_printname = (p) ->
	if (p.k != SYM)
		stop("symbol error")
	return p.printname

# clears the arglist too

# p and q are both U
set_binding = (p, q) ->
	if (p.k != SYM)
		stop("symbol error")
	binding[p - symtab] = q
	arglist[p - symtab] = symbol(NIL)

# p is a U
get_binding = (p) ->
	if (p.k != SYM)
		stop("symbol error")
	return binding[p - symtab]

# p,q,r are all U
set_binding_and_arglist = (p, q, r) ->
	if (p.k != SYM)
		stop("symbol error")
	binding[p - symtab] = q
	arglist[p - symtab] = r

# p is U
get_arglist = (p) ->
	if (p.k != SYM)
		stop("symbol error")
	return arglist[p - symtab]

# get symbol's number from ptr

# p is U
symnum = (p) ->
	if (p.k != SYM)
		stop("symbol error")
	return Math.floor(p - symtab)

# push indexed symbol

# k is an int
push_symbol = (k) ->
	push(symtab[k])

clear_symbols = ->
	for i in [0...NSYM]
		binding[i] = symtab[i]
		arglist[i] = symbol(NIL)