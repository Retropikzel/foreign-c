
for file in ./test/*.scm
do
    echo "Testing ${file}"
    ${SCHEME} ${file}
done
