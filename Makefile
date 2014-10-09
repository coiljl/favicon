
dependencies: dependencies.json
	@packin install --folder $@ --meta $<
	@ln -snf .. $@/favicon

test: dependencies
	@$</jest/bin/jest test

.PHONY: test
