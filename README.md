## シェルスクリプト覚え書き

### traffic.sh
日ごとのトラフィック量を計算。</br>
AWSとか月の総通信量制限があるやつ用。</br>
課金開始日でreset(reboot)させる。</br>
ifconfigからトラフィック値をとってるから、再起動とかすると取れない値があるため目安値。</br>
<pre># 出力ログ
/var/log/daylog.log</pre>

### usb_mount.sh
USB接続された外付け記憶装置を自動でマウントしたい</br>
swatchでログ監視してスクリプト実行？</br>

