#!/bin/bash

# Function to create and navigate to a Kubernetes container
function create_container() {
  kubectl run amp-demo --image=stanhoe/7zip:latest -- sh -c "sleep 9999999" &
}

# Function to check if the amp-demo pod is ready
function check_pod_ready() {
  echo "Waiting for amp-demo pod to be ready..."
  sleep 2
  echo
  while true; do
    POD_STATUS=$(kubectl get pod amp-demo -o jsonpath='{.status.phase}')
    if [[ "$POD_STATUS" == "Running" ]]; then
      echo "amp-demo pod is running."
      echo
      break
    else
      echo "Current status: $POD_STATUS. Checking again in 5 seconds..."
      sleep 5
    fi
  done
}

# Function to display the menu and handle user input
function display_menu() {
  while true; do
    echo
    echo "Choose an option:"
    echo "1. NotPetya Ransomware"
    echo "2. WannaCry Ransomware"
    echo "3. EternalRocks Malware"
    echo "4. BitcoinMiner Cryptominer"
    echo "5. Exit program"
    read -p "Enter choice [1-5]: " choice

    case $choice in
      1)
        kubectl exec -ti amp-demo -- sh -c "cd /tmp; wget https://github.com/fabrimagic72/malware-samples/raw/master/Ransomware/NotPetya/027cc450ef5f8c5f653329641ec1fed91f694e0d229928963b30f6b0d7d3a745-20170707033827.zip && 7z e 027cc450ef5f8c5f653329641ec1fed91f694e0d229928963b30f6b0d7d3a745-20170707033827.zip -p'infected'"
        echo
        printConsole
        ;;
      2)
        kubectl exec -ti amp-demo -- sh -c "cd /tmp; wget https://github.com/fabrimagic72/malware-samples/raw/master/Ransomware/Wannacry/32f24601153be0885f11d62e0a8a2f0280a2034fc981d8184180c5d3b1b9e8cf.zip && 7z e 32f24601153be0885f11d62e0a8a2f0280a2034fc981d8184180c5d3b1b9e8cf.zip -p'infected'"
        echo
        printConsole
        ;;
      3)
        kubectl exec -ti amp-demo -- sh -c "cd /tmp; wget https://github.com/fabrimagic72/malware-samples/raw/master/EternalRocks/cf8533849ee5e82023ad7adbdbd6543cb6db596c53048b1a0c00b3643a72db30.zip && 7z e cf8533849ee5e82023ad7adbdbd6543cb6db596c53048b1a0c00b3643a72db30.zip -p'infected'"
        echo
        printConsole
        ;;
      4)
        kubectl exec -ti amp-demo -- sh -c "cd /tmp; wget https://github.com/fabrimagic72/malware-samples/raw/master/Bitcoin%20miners/02ca4397da55b3175aaa1ad2c99981e792f66151.zip && 7z e 02ca4397da55b3175aaa1ad2c99981e792f66151.zip -p'infected'"
        echo
        printConsole
        ;;
      5)
        echo "Exiting program..."
        echo
        kubectl delete pod amp-demo 
        break
        ;;
      *)
        echo "Invalid option, please try again."
        echo
        ;;
    esac
done
}

function printConsole {
  echo
  echo "Successful executed malware in the container. Please head to the Aqua Console to review the Incident."
  echo
}

# Main script execution
create_container
check_pod_ready
display_menu
