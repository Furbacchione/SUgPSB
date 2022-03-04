tail -n +2 MyList.txt | while read p; do
  rm -R $p
  mkdir $p
  cd $p
  cutest2matlab $p.SIF
  cd ..
done 