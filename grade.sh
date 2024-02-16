CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo "File found"
else
    echo "File ListExamples.java not found"
    exit 1

fi

cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java

if [[ $? -ne 0 ]]
then
    echo "Compilation Error!"
    exit 1
fi

echo "Program compiled successfully"

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > Test-output.txt

# lastLine= $(cat Test-output.txt | tail -n 2| awk '{print $4}')
cat Test-output.txt | tail -n 2| head -n 1| awk -F'[, ]' '{print $3}'
cat Test-output.txt | tail -n 2| awk '{print $6}'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
