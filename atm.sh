clear
while true
do
path="/home/asif/script/atm.log"
echo "1.CREATE YOUR ACCOUNT"
echo "2.CHECK BALANCE"
echo "3.DEPOSITE"
echo "4.CREDIT"
echo "5.BALANCE DETAIL"
echo "6.EXIT"
echo -n "CHOSE ANY NUMBER: "
read num
if [[ ${num} -eq 1 ]]
then
echo -n "ENTER YOUR NAME: "
read name
echo -n "ENTER YOUR AGE: "
read age
echo -n "ENTER YOUR GENDER: "
read gen
echo -n "ENTER YOUR ADDRESS: "
read add
echo -n "ENTER FIRST DEPOSITE AMOUNT: "
read amt
acc=$(( RANDOM % 9000 + 1000 ))
echo  "YOUR ACCOUNT NUMBER IS:$acc"
echo "$name,$age,$gen,$add,$amt,$acc" >> "$path" 
psql -h localhost -U postgres -c "INSERT INTO atm VALUES ('$name', '$age', '$gen', '$add', '$amt', '$acc');"
fi
if [[ ${num} -eq 2 ]]
then
echo "ENTER YOUR ACCOUNT NUMBER: "
read acc

no=`psql -h localhost -U postgres -c "select account_no from atm where account_no=$acc;"|tail -2|cut -c 2|head -1`
if [[ $no -eq 1 ]]
then
bal=`psql -h localhost -U postgres -c "select balance from atm where account_no=$acc;"|tail -3|head -1`
echo "YOUR BALANCE IS: $bal"
else
echo "ACCOUNT NUMBER NOT FOUND"
fi 
fi
if [[ ${num} -eq 3 ]]
then
echo -n "ENTER YOUR ACCOUNT NUMBER: "
read acc
no=`psql -h localhost -U postgres -c "select account_no from atm where account_no=$acc;"|tail -2|cut -c 2|head -1`
if [[ $no -eq 1 ]]
then
echo -n "ENTER AMMOUNT FOR DEPOSITE: "
read amt
psql -h localhost -U postgres -c "UPDATE atm SET balance = balance + $amt WHERE account_no = $acc;"
echo "DEPOSITE SUCCESSFULL"
echo "$name,$age,$gen,$add,$amt,$acc" >>"$path"
else
echo "ACCOUNT NUMBER NOT FOUND"
fi
fi
if [[ ${num} -eq 4 ]]
then
echo -n "ENTER YOUR ACCOUNT NUMBER: "
read acc
no=`psql -h localhost -U postgres -c "select account_no from atm where account_no=$acc;"|tail -2|cut -c 2|head -1`
if [[ ${no} -eq 1 ]]
then
echo -n "ENTER AMMOUNT FOR CREDIT: "
read amt
psql -h localhost -U postgres -c "UPDATE atm SET balance = balance - $amt WHERE account_no = $acc;"
echo "CREDIT SUCCESSFULL"
fi
fi
if [[ ${num} -eq 5 ]]
then
echo -n "ENTER YOUR ACCOUNT NUMBER: "
read acc
no=`psql -h localhost -U postgres -c "select account_no from atm where account_no=$acc;"|tail -2|cut -c 2|head -1`
if [[ $no -eq 1 ]]
then
det=`cat $path |grep "$acc"`
echo $det
fi
fi
if  [[ ${num} -eq 6 ]]
then
echo "exiting...."
exit
fi
done
