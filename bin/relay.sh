#!/usr/bin/env bash

ME=$(basename $0)
USAGE="usage: $ME relay_number on|off"

type -t curl >/dev/null || { echo "$ME: no curl command found"; exit 1; }

TOKEN=$SPARK_ACCESS_TOKEN
CORE_ID=$SPARK_CORE_ID
[[ -z "$TOKEN" ]] && echo "$ME: no token defined in env" && exit 1
[[ -z "$CORE_ID" ]] && echo "$ME: no core id defined in env" && exit 1

RELAY=$1
ACTION=$2
[[ -z "$RELAY" || -z "$ACTION" ]] && echo "$USAGE" && exit 1

ACTION=$(echo $ACTION | tr '[:lower:]' '[:upper:]')

[[ $RELAY -lt 0 || $RELAY -gt 3 ]] && echo "$ME: valid relays are 0 thru 3" && exit 1
case $ACTION in
ON|HIGH) ACTION=HIGH ;;
OFF|LOW) ACTION=LOW ;;
*) echo "$ME: valid actions are on|off"; exit 1 ;;
esac

CMD="curl -s https://api.spark.io/v1/devices/$CORE_ID/digitalwrite -d access_token=$TOKEN -d params=D${RELAY},$ACTION"
echo $CMD

$CMD
echo
