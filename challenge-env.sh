#!/bin/bash -x
function solver() {
  SOLVER_IMAGE=ghcr.io/javajon/solver:0.5.4   ## <-- Set to the latest semver from https://github.com/javajon/katacoda-solver/releases]
  SCENARIOS_ROOT=~/dev/projets/perso/katacoda/herveleclerc-katacoda               ## <-- Set to your base source directory for your challenges and scenarios
  if [[ ! "$(pwd)" =~ ^$SCENARIOS_ROOT.* ]]; then
    echo "Please run this from $SCENARIOS_ROOT or one of its scenario or challenge subdirectory."
    return 1;
  fi
  SUBDIR=$(echo $(pwd) | ggrep -oP "^$SCENARIOS_ROOT\K.*")
  docker run --rm -it -v "$SCENARIOS_ROOT":/workdir -w /workdir/$SUBDIR $SOLVER_IMAGE "$@";
}
