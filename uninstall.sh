user=$(whoami)

if [ $1 == "server" ]
then
    echo "Removing Server"
    echo ""
    sudo rm -rf /home/$user/.transferpi
    sudo service bhejo stop
    sudo rm -rf /lib/systemd/system/bhejo.service
    echo "Server Removed Successfully"
else
    if [ $1 == 'client' ]
    then
        echo "Removing Client"
        echo ""
        sudo rm -rf /home/$user/.transferpi
        sudo rm -rf /usr/local/bin/lao
        echo "Client Removed Successfully"
    else
        echo "Please Choose Between Server And Client"
    fi
fi
