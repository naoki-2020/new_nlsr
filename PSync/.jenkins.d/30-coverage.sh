#!/usr/bin/env bash
set -ex

if [[ $JOB_NAME == *"code-coverage" ]]; then
    lcov --quiet \
         --capture \
         --directory . \
         --no-external \
         --rc lcov_branch_coverage=1 \
         --output-file build/coverage-with-tests.info

    lcov --quiet \
         --remove build/coverage-with-tests.info "$PWD/tests/*" \
         --rc lcov_branch_coverage=1 \
         --output-file build/coverage.info

    genhtml --branch-coverage \
            --demangle-cpp \
            --legend \
            --output-directory build/coverage \
            --title "PSync unit tests" \
            build/coverage.info
fi
