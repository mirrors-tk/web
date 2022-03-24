#!/bin/bash
HOST=${1:-"mirrors.tk"}

echo "# robots.txt for https://$HOST" > robots.txt
echo 'User-agent: *' >> robots.txt
echo '' >> robots.txt
echo 'Disallow: /logs' >> robots.txt

curl -s https://$HOST/status.json | jq -r '.[] | .name' | uniq | while read name; do
	[[ -z ${name} ]] && continue
	echo "Disallow: /${name}" >> robots.txt
done
