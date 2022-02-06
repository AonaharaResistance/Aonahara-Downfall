.PHONY: format

format:
	find . -name '*.gd' -print0 | xargs -0 -P $(nproc) gdformat
