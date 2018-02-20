function line(){
echo "************************************"
}

echo "Your username :$(echo $USER)"
line # call function

echo"Current date and time:$(date)"
line

echo"Currently logged on user:"
who
line
 
