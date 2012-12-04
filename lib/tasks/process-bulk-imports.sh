for res in `s3cmd ls s3://dctrs-io-imports/output/bulk2/ | grep -o 'part-.*$'`
do
  echo $res
  s3cmd get s3://dctrs-io-imports/output/bulk2/$res
  curl -XPOST http://localhost:9200/providers/_bulk --data-binary @$res > $res.log
  rm $res
  s3cmd put se://dctrs-io-imports/bulk-index-results/$res
  echo "finished $res"
done

for res in `ls .`
do
  echo $res
  curl -XPOST http://localhost:9200/providers/_bulk --data-binary @$res > ../log/$res.log
  rm $res
  echo "finished $res"
done

