#!/bin/bash

source config/night_shift.sh

# Test makefile target for production
make scaffold && make -t $NIGHT_SHIFT_TARGETS
maketest_exit=$?

# Collect unused or wrong makefile targets.
night-shift/tests/diff_make_targets.sh
makedifftest_exit=$?

# Check unused files in the script folder.
python night-shift/tests/check_unused_files.py -d script Makefile *.mk night-shift/lib/run_workflow.sh $NIGHT_SHIFT_ENTRY
unusedtest_exit=$?

exit $(($maketest_exit + $makedifftest_exit + $unusedtest_exit))
