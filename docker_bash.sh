# Insufficient number of arguments
if [ $# -lt 1 ]; then
    echo "Usage: ./run_docker.sh [run|build|remove]"
    exit 1
fi

case $1 in
    "run")
        # Run the docker container
        docker run -v ./:/src/ --rm --gpus devices=$CUDA_VISIBLE_DEVICES -d -it -p 37332:37332  --name test-llamaindex-container test-llamaindex
        ;;
    "exec")
        # Execute the models inside the docker container
        docker exec -it test-llamaindex-container bash      
        ;;
    "build")
        # Build the docker
        docker build ./ -t test-llamaindex
        ;;
    "stop")
        # Stop the docker container
        docker stop test-llamaindex-container
        ;;
    "remove")
        # Remove the docker container
        docker stop test-llamaindex-container &&
        docker remove test-llamaindex-container
        ;;
    "*")
        # Invalid argument
        Echo "Invalid argument"
        ;;
esac