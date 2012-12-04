
mkdir providers
split -a 2 -l 38000 providers.csv providers/
for file in `ls .`; do gzip $file; done
for file in `ls .`; do s3cmd put $file s3://dctrs-io-imports/input/$file; done
