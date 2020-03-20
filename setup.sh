user=$(whoami)
service_file="bhejo.service"

if [ $1 == "server" ]
then
    echo "Installing Server"
    echo ""
    echo "Installing Dependencies"
    sudo apt install -y python3-pip
    sudo -H pip3 install --upgrade flask flask_cors 

    echo "Create Config"
    echo ""
    echo "Enter Root Folder:"
    read root_folder
    echo "Enter Port:"
    read port
    mkdir -p /home/$user/.transferpi 
    echo "{" > config.json
    echo "\"root_dir\": \"$root_folder\"," >> config.json
    echo "\"port\": \"$port\"" >> config.json
    echo "}" >> config.json
    mv config.json /home/$user/.transferpi/config.json

    echo "Installing Service"
    echo [Unit] > $service_file
    echo Description=Transfer PI Server. >> $service_file
    echo "" >> $service_file
    echo [Service] >> $service_file
    echo Type=simple >> $service_file
    echo ExecStart=/usr/bin/python3 /home/$user/.transferpi/bhejo.py $user >> $service_file
    echo "" >> $service_file
    echo [Install] >> $service_file
    echo WantedBy=multi-user.target >> $service_file
 
    mkdir -p /home/$user/.transferpi
    sudo cp bhejo.py /home/$user/.transferpi/bhejo.py -a
    sudo mv bhejo.service /lib/systemd/system/bhejo.service 
    echo "Server Installied Successfully"
    echo "Starting Service"
    sudo service bhejo start
else
    if [ $1 == 'client' ]
    then
        echo "Installing Client"
        mkdir -p /home/$user/.transferpi
        echo ""
        echo ""
        echo "Installing Dependencies"
        sudo apt install -y python3-pip
        pip3 install --upgrade request tqdm
        echo ""
        echo "Enter Server's Public IPv4: "
        read ipv
        echo "Enter Port: "
        read port
        echo "{" > config.json
        echo "\"address\": \"$ipv\"," >> config.json
        echo "\"port\": \"$port\"" >> config.json
        echo "}" >> config.json
        mv config.json /home/$user/.transferpi/config.json
        chmod +x lao
        sudo cp lao /usr/local/bin/lao -a
        echo "Usage: lao file_path_on_server file_output_path"
    else
        echo "Please Choose Between Server And Client"
    fi
fi
