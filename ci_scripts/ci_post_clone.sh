#!/bin/sh

set -e

# SwiftLint on Analyze action

if [ $CI_XCODEBUILD_ACTION = 'analyze' ];
then
    echo "Linting..."
    brew install swiftlint

    cd $CI_PRIMARY_REPOSITORY_PATH
    swiftlint --strict
fi
