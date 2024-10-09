for f in images/thumbs/*; do convert "$f" -resize 510 "$f"; done
echo "thumbs generated"