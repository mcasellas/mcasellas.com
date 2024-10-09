for file in images/*; do
    if [ -f "$file" ]; then  # Check if it's a regular file
        # Remove leading hyphens and underscores
        new_name=$(echo "$file" | sed 's|^[_-]*||')
        mv "$file" "$(dirname "$file")/$new_name"
    fi
done
echo "Files renamed to remove leading hyphens and underscores."
cp images/* images/fulls
cp images/fulls/* images/thumbs
echo "images transferred"
rm images/*.jpg
rm images/*.JPG
rm images/*.png
for f in images/thumbs/*; do convert "$f" -resize 510 "$f"; done
echo "thumbs generated"