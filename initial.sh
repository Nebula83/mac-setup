echo "-- BOOTSTRAP SCRIPT, RUN UNTIL 'BOOTSTRAP COMPLETE' IS DISPLAYED --"

ssh_key_file=/Users/$USER/.ssh/id_ed25519.pub
if ! [ -f $ssh_key_file ]
then
  echo "+ Creating an SSH key for you..."
  ssh-keygen -t ed25519
else
  echo "+ SSH key exists"
fi
cat /Users/$USER/.ssh/id_ed25519.pub

echo "+ Please add this public key to Github \n"
echo "  https://github.com/account/ssh \n"
read -p "  Press [Enter] key after this..."

if ! command -v git 2>&1 >/dev/null
then
  echo "+ Installing xcode-stuff, takes around 15 minutes"
  xcode-select --install
else
  echo "+ xcode is installed"
fi

if ! command -v ansible  2>&1 >/dev/null
then
  echo "+ Install ansible for further configuration"
  python3 -m pip install --user ansible

else
  echo "+ Ansible is installed"
fi

zsh_env_file=$HOME/.zshenv
if ! [ -f $zsh_env_file ]
then
  echo "+ Creating zsh env"
  touch $zsh_env_file
fi

ansible_path="/Users/$USER/Library/Python/3.9/bin"
if ! grep -Fq $ansible_path $zsh_env_file
then
  echo "+ Adding ansible to PATH"
  echo "export PATH=\"\$PATH:$ansible_path\"" >> $zsh_env_file
  echo "  source '. ~/.zshenv' or reload the shell"
fi

