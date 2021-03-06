$PBExportHeader$w_test.srw
forward
global type w_test from window
end type
type cbx_dbgtokens from checkbox within w_test
end type
type mle_debug from multilineedit within w_test
end type
type mle_eval from multilineedit within w_test
end type
type cb_eval from commandbutton within w_test
end type
type cbx_postfix from checkbox within w_test
end type
type mle_polish from multilineedit within w_test
end type
type cb_parse from commandbutton within w_test
end type
type mle_tokens from multilineedit within w_test
end type
type cb_tokenize from commandbutton within w_test
end type
type mle_formula from multilineedit within w_test
end type
type s_test from structure within w_test
end type
end forward

type s_test from structure
	character		s1[20]
	long		l2
end type

global type w_test from window
integer width = 2203
integer height = 1536
boolean titlebar = true
string title = "Shunting-Yard evaluator"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_dbgtokens cbx_dbgtokens
mle_debug mle_debug
mle_eval mle_eval
cb_eval cb_eval
cbx_postfix cbx_postfix
mle_polish mle_polish
cb_parse cb_parse
mle_tokens mle_tokens
cb_tokenize cb_tokenize
mle_formula mle_formula
end type
global w_test w_test

type prototypes

Function ULong GetLocaleInfo(ulong Locale, ulong LCType, ref string lpLCData, ulong cchData) Library "kernel32.dll" Alias for "GetLocaleInfoW" 
Function ULong GetSystemDefaultLCID() Library "kernel32.dll"
Function ULong GetUserDefaultLCID() Library "kernel32.dll"

end prototypes

type variables

nv_parser i_parser

end variables

forward prototypes
public subroutine showerror (string as_return)
end prototypes

public subroutine showerror (string as_return);

if match(as_return, "at [0-9]+$") then
	long offset
	string ls_tmp
	offset = long(mid(as_return,lastpos(as_return,' ')))
	ls_tmp = fill('-', offset - 1) + "^"
	mle_formula.text += "~r~n" + ls_tmp
end if


end subroutine

on w_test.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.cbx_dbgtokens=create cbx_dbgtokens
this.mle_debug=create mle_debug
this.mle_eval=create mle_eval
this.cb_eval=create cb_eval
this.cbx_postfix=create cbx_postfix
this.mle_polish=create mle_polish
this.cb_parse=create cb_parse
this.mle_tokens=create mle_tokens
this.cb_tokenize=create cb_tokenize
this.mle_formula=create mle_formula
this.Control[]={this.cbx_dbgtokens,&
this.mle_debug,&
this.mle_eval,&
this.cb_eval,&
this.cbx_postfix,&
this.mle_polish,&
this.cb_parse,&
this.mle_tokens,&
this.cb_tokenize,&
this.mle_formula}
end on

on w_test.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_dbgtokens)
destroy(this.mle_debug)
destroy(this.mle_eval)
destroy(this.cb_eval)
destroy(this.cbx_postfix)
destroy(this.mle_polish)
destroy(this.cb_parse)
destroy(this.mle_tokens)
destroy(this.cb_tokenize)
destroy(this.mle_formula)
end on

event open;
//12.3 'toto' truc false
//mle_formula.text = "33+42*2.5/(0.1-5)^2^3"
//mle_formula.text = "1*sum()"
//mle_formula.text = "2+3*4"
//mle_formula.text = "answer()*sum(1)"
//mle_formula.text = "2^ (abs  (sum(2 ;-3 ; 4))-1)+1"
//mle_formula.text = "2^ abs(sum(2;-3;4))"
//mle_formula.text = "2 - 1 <= 1 + 1"
//mle_formula.text = "+1 + --+1 = 2 = not(true)"
//mle_formula.text = "+1 + --+1" // attendu 2
//mle_formula.text = "true and not false"
//mle_formula.text = "len('toto') = 4"
//mle_formula.text = "min(len('toto')+7;-len(~"machin~");4.2)"
//mle_formula.text = "12.3 'toto' 42 false myvar"
mle_formula.text = "min(len('toto')+7;-len(~"machin~");4.2)+13"

end event

type cbx_dbgtokens from checkbox within w_test
integer x = 1810
integer y = 288
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "debug --->"
end type

event clicked;
if checked then
	parent.width = 3287
else
	parent.width = 2203
end if

end event

type mle_debug from multilineedit within w_test
integer x = 2199
integer y = 64
integer width = 1015
integer height = 1160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type mle_eval from multilineedit within w_test
integer x = 37
integer y = 1028
integer width = 2117
integer height = 196
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean hscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_eval from commandbutton within w_test
integer x = 41
integer y = 928
integer width = 402
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&eval"
end type

event clicked;

long i
string ls_res
nv_termqueue lt_parsed

lt_parsed = i_parser.getparsed()

ls_res = i_parser.eval(lt_parsed)

showerror(ls_res)

mle_eval.text = ls_res
end event

type cbx_postfix from checkbox within w_test
integer x = 471
integer y = 608
integer width = 1074
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "postfix (uncheck for prefix - won~'t evaluate)"
boolean checked = true
end type

type mle_polish from multilineedit within w_test
integer x = 37
integer y = 704
integer width = 2117
integer height = 196
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_parse from commandbutton within w_test
integer x = 37
integer y = 608
integer width = 402
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&parse"
end type

event clicked;
long i
nv_termqueue lt_tokens, lt_parsed

i_parser.setreverse( cbx_postfix.checked )
//mle_formula.text = fixdecimal(mle_formula.text)

if i_parser.tokenize( mle_formula.text ) then
	lt_tokens = i_parser.getterms()
	if i_parser.parse(lt_tokens) then
		lt_parsed = i_parser.getparsed()
		mle_polish.text = ""
		for i = 1 to lt_parsed.size()
			mle_polish.text += lt_parsed.peek(i).dump() + ' '
		next
	else
		mle_polish.text = i_parser.getlasterror()
	end if

end if

end event

type mle_tokens from multilineedit within w_test
integer x = 37
integer y = 388
integer width = 2117
integer height = 196
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_tokenize from commandbutton within w_test
integer x = 37
integer y = 288
integer width = 402
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&tokenize"
end type

event clicked;
long i, p
string ls_err, ls_form
nv_termqueue terms

ls_form = mle_formula.text
p = pos(ls_form, "~r~n")
if p > 0 then ls_form = left(ls_form, p - 1)

//ls_form = fixdecimal(ls_form)
mle_formula.text = ls_form

if i_parser.tokenize( ls_form ) then
	terms = i_parser.getterms()
	mle_tokens.text = ""
	if cbx_dbgtokens.checked then mle_debug.text = ""
	for i = 1 to terms.size()
		mle_tokens.text += terms.peek(i).dump() + ' '
		if cbx_dbgtokens.checked then 
			mle_debug.text += terms.peek(i).dump() + &
									' [' + terms.peek(i).typename() + ']' +&
									iif(terms.peek(i).kind = nv_term.UNARYOP or terms.peek(i).kind = nv_term.BINARYOP, " p=" + string(i_parser.getprec(terms.peek(i))), "") + &
									' ' + terms.peek(i).classname() +&
									'~r~n' 
		end if 
	next
else
	ls_err = i_parser.getlasterror()
	showerror(ls_err)
	mle_tokens.text = ls_err
end if


end event

type mle_formula from multilineedit within w_test
integer x = 37
integer y = 64
integer width = 2117
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

