#!/bin/bash

# Das --user-data-dir sollte nach Änderungen jedesmal gelöscht werden
rm -R ./quic-userdata
# Die Prüfsumme wird bei der Zertifikatsgeneierung am Ende ausgegeben und hier über sed eingetragen
google-chrome-stable --user-data-dir=./quic-userdata --origin-to-force-quic-on=test.local:433 --ignore-certificate-errors-spki-list=D6zH1r74GQbJjyHiu1WmBIhAZ+NN0uyrbt9vi18taKY=

