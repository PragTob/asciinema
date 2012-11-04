all: bin/asciiio

bin/asciiio: tmp/asciiio.zip
	echo '#!/usr/bin/env python' > bin/asciiio
	cat tmp/asciiio.zip >> bin/asciiio
	chmod +x bin/asciiio

tmp/asciiio.zip: src/__main__.py src/asciicasts.py src/recorders.py src/timed_file.py src/uploader.py src/config.py src/options.py src/cli.py src/asciicast_recorder.py
	mkdir -p tmp
	rm -rf tmp/asciiio.zip
	cd src && zip ../tmp/asciiio.zip *.py