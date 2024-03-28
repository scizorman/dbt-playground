#!/bin/bash
set -euo pipefail

modules_dir=$(git rev-parse --show-toplevel)/stacks/terraform/modules

find "$modules_dir" -type d -name tests -exec dirname {} + \
  | sed "s|$modules_dir|modules|" \
  | sort -n \
  | uniq \
  | while read -r module; do make test MODULE="$module"; done
