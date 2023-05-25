#!/bin/bash

docker compose exec directus sh -c "npx directus schema snapshot ./snapshots/$(date +%F)-snapshot-$(date +%s).yaml"
