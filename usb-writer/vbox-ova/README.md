# VirtualBox OVA版のUSBメモリを大量に準備する方法

1. 機械のチェック

   * Linuxマシンに他ポートUSBハブを接続
   * USBメモリを接続した時にどのブロックデバイスとなるかを確認
     (実際に接続してみて、dmesg で /dev/sdc などの表示を確認)
   * devices.sh 中の変数 DEV を確認
     (ハードドライブに割り当てられているブロックデバイスが含まれていると、ハードディスクが破壊されるので注意)

2. 配布物が入ったディレクトリを作成。標準では

    * MateriAppsLive-x.x-i386.ova
    * VirtualBox-*-OSX.dmg
    * VirtualBox-*-Win.exe
    * README-en.html
    * README.html
    * setup-en.pdf
    * setup.pdf
    * vbconfig.bat
    * vbconfig.command

   最初の3つ以外は https://github.com/cmsi/MateriAppsLive/tree/master/ova にある

   必要に応じて、講習会用資料や実習用素材も含める

3. MD5SUM を作成し中身を確認

   ```
   sh /script/dir/generate_md5.sh
   ```

4. USBメモリを接続。check_dev.sh の実行結果が、✕から○に変化したことを確認

5. USBメモリへの書き込み

   ```
   sudo sh /script/dir/write_ova_all.sh
   ```

   * 経験上50本に1本程度はチェックが失敗する
   * 正しいチェックサムが得られたUSBメモリには、MD5SUM-checked という空のファイルができている
   
6. 書き込みが終了したらUSBメモリを取り外す
