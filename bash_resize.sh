# Step 1: Rename all files in images/* to remove leading hyphens and underscores
for file in images/*; do
    if [ -f "$file" ]; then  # Check if it's a regular file
        # Remove leading hyphens and underscores
        new_name=$(echo "$(basename "$file")" | sed 's|^[_-]*||')
        mv "$file" "images/$new_name"
    fi
done
echo "Files renamed to remove leading hyphens and underscores."

# Step 2: Copy images to fulls and thumbs directories
cp images/* images/fulls
cp images/fulls/* images/thumbs
echo "Images transferred."

# Step 3: Remove original images with specific extensions
rm images/*.jpg
rm images/*.JPG
rm images/*.png
echo "Original images removed."

# Step 4: Resize images in thumbs directory
for f in images/thumbs/*; do
    convert "$f" -resize 510 "$f"
done
echo "Thumbnails generated."
