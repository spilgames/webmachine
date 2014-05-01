ERL          ?= erl
APP          := webmachine

REPO = ${shell echo `basename "$${PWD}"`}
ARTIFACTSFILE = ${shell echo ${REPO}-`date +%F_%H-%M-%S`.tgz}

.PHONY: deps

<<<<<<< HEAD
all: deps
	@(rebar compile)
=======
all: deps compile

compile: deps
	./rebar compile
>>>>>>> 0f2d95ae347b27bce34ca34e884f6d26ec611689

deps:
	@(rebar get-deps)

clean:
	@(rebar clean)

distclean: clean
	@(rebar delete-deps)

edoc:
	@$(ERL) -noshell -run edoc_run application '$(APP)' '"."' '[{preprocess, true},{includes, ["."]}]'
DIALYZER_APPS = kernel stdlib sasl erts ssl tools os_mon runtime_tools crypto inets \
	xmerl webtool snmp public_key mnesia eunit syntax_tools compiler
COMBO_PLT = $(HOME)/.webmachine_dialyzer_plt

include tools.mk

<<<<<<< HEAD
test: all
	@(rebar skip_deps=true eunit)
=======
verbosetest: all
	@(./rebar -v skip_deps=true eunit)
>>>>>>> 0f2d95ae347b27bce34ca34e884f6d26ec611689

travisupload:
	tar cvfz ${ARTIFACTSFILE} --exclude '*.beam' --exclude '*.erl' test.log .eunit
	travis-artifacts upload --path ${ARTIFACTSFILE}
