#!/bin/bash
# Randomly delete pods in a Kubernetes namespace.
set -e

: "${MIN_DELAY_IN_SECS:=30}"
: "${MAX_DELAY_IN_SECS:=90}"
: "${NAMESPACE:=default}"
: "${EXCLUDED_POD_PREFIX:="NONE"}"

echo "MIN_DELAY_IN_SECS=${MIN_DELAY_IN_SECS}"
echo "MAX_DELAY_IN_SECS=${MAX_DELAY_IN_SECS}"
echo "NAMESPACE=${NAMESPACE}"
echo "EXCLUDED_POD_PREFIX=${EXCLUDED_POD_PREFIX}"

while true; do
    pod_name=$(kubectl \
        --namespace "${NAMESPACE}" \
        -o 'jsonpath={.items[*].metadata.name}' \
        get pods | \
        grep -v "${IGNORED_POD_PREFIX}" | \
        tr " " "\n" | \
        shuf | \
        head -n 1)

    out=$(echo ${pod_name} | xargs --no-run-if-empty \
        kubectl --namespace "${NAMESPACE}" delete pod)  # -t
    echo "[$(date '+%Y/%m/%d %H:%M:%S')] ${out}"
    sleep "$(shuf -i ${MIN_DELAY_IN_SECS}-${MAX_DELAY_IN_SECS} -n 1)"
done
