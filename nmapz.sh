

python3 ./gen_nmap.py;

while read item; do
    # Extract IP and ports separately
    ip=$(echo "$item" | awk '{print $1}')
    ports=$(echo "$item" | awk -F '-p ' '{print $2}' | sed 's/,$//')

    # Run nmap using the cleaned-up IP and port range
    nmap -p "$ports" "$ip"
done < nmap.txt

rm mscan.txt nmap.txt
