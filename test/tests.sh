set -o errexit
for i in *.moon; do
  moon $i 
done
