
for file in ./test/*.scm
do
    echo "==========================================================="
    echo "Testing ${file}, with ${SCHEME}"
    echo "==========================================================="
    ${SCHEME} ${file}
    ${file//.scm/}
done
