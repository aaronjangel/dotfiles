#!/bin/sh

if [ -f ~/.bashrc.d/.enabled ]; then
  echo It appears that processing of \~/.bashrc.d/ has already been enabled. Do
  echo you want to reinstall it?
  echo
  echo -n Reinstall? [y/N]: 
  read reinstall

  echo

  case $reinstall in
    y|Y)
      echo Continuing with installation.
      echo
      ;;
    *)
      echo Installation cancelled at user request.
      exit 1
      ;;
  esac
fi

if [ "$(pwd)" != "$HOME" ]; then
  exec sh -c "cd $HOME; exec $(pwd)/${0#./}"
fi

echo Creating ~/.bashrc.d directory...
mkdir -p .bashrc.d

echo Patching ~/.bashrc...
cat <<EOF > .bashrc

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

echo <<EOF
Done.

Your .bashrc file has been modified to source files marked as executable in
the \~/.bashrc.d/ directory. Please open a new shell to make this effective.
EOF
