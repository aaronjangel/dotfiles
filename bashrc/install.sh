#!/bin/sh

if [ $(grep -c bashrc.d ~/.bashrc) != 0 ]; then
  echo It appears that processing of \~/.bashrc.d/ has already been enabled.
  exit 1
fi

mkdir -p ~/.bashrc.d
cat <<EOF > ~/.bashrc

# More bashrc files
# You may want to put additional bashrc functionality in separate
# files in the ~/.bashrc.d directory, instead of directly adding more
# more code to this file.

for file in ~/.bashrc.d/*; do
  if [ -x $file ]; then
    . $file
  fi
done
EOF

echo Done.
