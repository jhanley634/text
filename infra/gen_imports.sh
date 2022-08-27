#! /usr/bin/env bash
# Copyright 2022 John Hanley. MIT licensed.
#
# Scans the source tree and summarizes all imports found.
# This is useful for verifying the conda environment is working properly.
#

VERIFY=infra/verify_imports.py
set -e -u
cd ../text
cat  > ${VERIFY}  <<EOF
#! /usr/bin/env python
# Copyright 2022 John Hanley. MIT licensed.
"""
Verifies that packages load without error, e.g. due to missing deps.
"""
# ignore F401 "imported but unused"
EOF

find . -name '*.py' |
  sort |
  xargs egrep -h '^import |^from [^.]' |
  sed -e 's/ as .*//' |
  awk '{print $0, " # noqa F401"}' |
  sort -u  >> ${VERIFY}

chmod a+x ${VERIFY}
isort ${VERIFY}
