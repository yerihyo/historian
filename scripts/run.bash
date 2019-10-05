#!/bin/bash -eu

ARG0=${BASH_SOURCE[0]}
FILE_PATH=$(readlink -f $ARG0)
FILE_DIR=$(dirname $FILE_PATH)
FILE_NAME=$(basename $FILE_PATH)

SCRIPTS_DIR=$FILE_DIR
REPO_DIR=$(dirname $SCRIPTS_DIR)

FOXYLIB_DIR=$HOME/projects/foxytrixy/foxylib


errcho(){ >&2 echo $@; }

export SKIP_WARMUP=1
export FLASK_ENV=development
export FLASK_APP="khala.main.run" #:create_app"
export ELASTICSEARCH_HOST="http://localhost:9200"

export PYTHONPATH=$FOXYLIB_DIR


main(){
#    flask run
    python -m khala.main.chatapp.discord.connect
}
# $REPO_DIR/khala/scripts/run.bash >& $REPO_DIR/log/khala.log &

#python -m delphi.app.main.run
# sudo gunicorn -b 0.0.0.0:80 "delphi.app.main.run:create_app"
# check http://localhost:5000/ui/#!/

pushd $REPO_DIR

errcho "[$FILE_NAME] start (REPO_DIR:$REPO_DIR)"
main
errcho "[$FILE_NAME] end (REPO_DIR:$REPO_DIR)"

popd
