#!/bin/bash

echo ""
echo "Please red carefully :"
echo "This script renames files with non-ASCII characters in their names to ASCII equivalents."
echo "It will search in this folder and recursively IN ALL SUBFOLDERS !!."
echo ""
echo "Please confirm that you want to proceed by typing 'yes' and pressing Enter:"
read confirmation

if [ "$confirmation" != "yes" ]; then
  echo "Exiting the script. No changes were made."
  exit 1
fi

echo "Proceeding with the script..."

find . -mindepth 1 -depth -name '*[^\x00-\x7F]*' -not -name 'rename_script.sh' -print0 | while IFS= read -r -d '' file; do
  if [ "$file" != "." ]; then
    new_name="$(echo "$file" | iconv -t ASCII//TRANSLIT)"
    if [ "$file" != "$new_name" ]; then
      mv "$file" "$new_name"
    fi
  fi
done

echo "Script completed successfully."
