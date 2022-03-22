#!/bin/bash

FREQUENCY=1                                          # Delay between each check for completion
BACKGROUND_SIGNAL_FILE='/opt/.backgroundfinished'    # File updated by background to indicate completion
BACKGROUND_SAFE_WORD='done'                          # Word in BACKGROUND_SIGNAL_FILE indicating completion
START_MESSAGE='Starting scenario'                    # Message before the progress animation
END_NORMAL_MESSAGE='Challenge ready.'
END_KILLED_MESSAGE='Interupted. This scenario may still be initializing.'

SPINNER_COLOR_NUM=2                # Color to use, unless COLOR_CYCLE=1
SPINNER_COLOR_CYCLE=0              # 1 to rotate colors between each animation
INTERVAL=.25
SPINNER_NORMAL=$(tput sgr0)        # Reset encoding
symbols=("▐⠂       ▌" "▐⠈       ▌" "▐ ⠂      ▌" "▐ ⠠      ▌" "▐  ⡀     ▌" "▐  ⠠     ▌" "▐   ⠂    ▌" "▐   ⠈    ▌" "▐    ⠂   ▌" "▐    ⠠   ▌" "▐     ⡀  ▌" "▐     ⠠  ▌" "▐      ⠂ ▌" "▐      ⠈ ▌" "▐       ⠂▌" "▐       ⠠▌" "▐       ⡀▌" "▐      ⠠ ▌" "▐      ⠂ ▌" "▐     ⠈  ▌" "▐     ⠂  ▌" "▐    ⠠   ▌" "▐    ⡀   ▌" "▐   ⠠    ▌" "▐   ⠂    ▌" "▐  ⠈     ▌" "▐  ⠂     ▌" "▐ ⠠      ▌" "▐ ⡀      ▌" "▐⠠       ▌")

progress_pid=0

cleanup () {
  kill $progress_pid >/dev/null 2>&1
  progress_pid=-1
  end_message=$END_KILLED_MESSAGE
}

show_progress () {  
  while :; do
    tput civis
    for symbol in "${symbols[@]}"; do
      if [ $SPINNER_COLOR_CYCLE -eq 1 ]; then
        if [ $SPINNER_COLOR_NUM -eq 7 ]; then
          SPINNER_COLOR_NUM=1
        else
          SPINNER_COLOR_NUM=$((SPINNER_COLOR_NUM+1))
        fi
      fi
      local color
      color=$(tput setaf ${SPINNER_COLOR_NUM})
      tput sc
      printf "%s%s%s  " "${color}" "${symbol}" "${SPINNER_NORMAL}"
      tput rc
      sleep "${INTERVAL}"
    done
  done
  tput cnorm
  return 0
}

start_progress () {
  show_progress &
  progress_pid=$!

  # Catch any exit and stop progress animation
  trap cleanup SIGINT EXIT INT QUIT TERM

  clear && echo -n "$START_MESSAGE "

  # Periodically check for background signal or user Ctrl-C interuption
  end_message=$END_NORMAL_MESSAGE
  while [[ $progress_pid -ge 0 ]]; do
    grep -i ${BACKGROUND_SAFE_WORD} ${BACKGROUND_SIGNAL_FILE} &> /dev/null
    if [[ "$?" -eq 0 ]]; then
      kill $progress_pid >/dev/null 2>&1
      break
    fi
    sleep ${FREQUENCY}
  done

  stty sane; tput cnorm; clear
  printf "%s\n\n" "${end_message}"
  
  # Pick up any changes during background
  source ~/.bashrc

  mkdir -p /opt/.logs

  # In shell context for student, so set any environment variables for learner here, if needed:

  sudo apt-get install -y etcd-client
  mkdir -p /data
  ETCDCTL_API=3 etcdctl version

  openssl genrsa -out /root/alterway-key.pem 2048 2>/dev/null
  openssl req -new -key /root/alterway-key.pem -out /root/alterway-csr.pem -subj "/CN=alterway/O=DT" 2>/dev/null
 
   echo "Veuillez attendre que le challenge soit prêt.(30s)"
   sleep 30

  kubectl apply -f /opt/.logs/pv-1.yaml 2>/dev/null
  kubectl create secret generic supersecret -n kube-system --from-literal acopier=alterway2022 2>/dev/null

  kubectl get secret supersecret -n kube-system -o jsonpath='{.data.acopier}' | base64 --decode > /opt/.logs/supersecret.txt

  kubectl create ns app002 2>/dev/null
  kubectl run myapp002 -n app002 --image=paulbouwer/hello-kubernetes:1 --env=MESSAGE=BONJOURBONJOUR 2>/dev/null

}

clear && start_progress