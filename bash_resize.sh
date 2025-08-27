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
# Logo
# for f in images/*; do
#     [ -f "$f" ] || continue
#     base=$(basename "$f")
#     convert "$f" logo.png \
#         -gravity southeast \        # cantonada inferior dreta
#         -geometry +20+20 \          # marge 20px horitzontal i vertical
#         -composite "$f"
#     echo "Watermarked $base"
# done
echo "Images transferred."

# Step 3: Resize images in thumbs directory
for f in images/*; do
    if [ -f "$f" ]; then
        base=$(basename "$f")
        convert "$f" -resize 510 "images/thumbs/$base"
        echo "Creating thumbnail for $f"
    fi
done
echo "Thumbnails generated."



# Step 4: Remove original images with specific extensions
rm images/*.jpg
rm images/*.JPG
rm images/*.png
echo "Original images removed."

# Step 5: Remove orphan thumbs (files in thumbs without a corresponding file in fulls)
for thumb in images/thumbs/*; do
    base=$(basename "$thumb")
    if [ ! -f "images/fulls/$base" ]; then
        echo "Deleting orphan thumb: $thumb"
        rm "$thumb"
    fi
done
echo "Orphan thumbs removed."