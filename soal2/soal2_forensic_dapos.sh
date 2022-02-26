#!/bin/bash

root=/home/fidhiaaka/praktikum2

#2a
mkdir "$root"/forensic_log_website_daffainfo_log

#2b

#2c
awk 'BEGIN {FS=":";max=0;ipmax="";}
{
  if(NR>1){
    ip[$1]++ #menyimpan IP ke array
  }
}
END {
  max=0 #set 0 untuk perbandingan
  ipmax=""
  for (b in ip){
    if(ip[b]>max){ #cek tiap IP dengan banyak request
      ipmax=b
      max=ip[b]
    }
  }
  print "IP yang paling banyak mengakses server adalah:", ipmax, "sebanyak", max, "requests\n"
}
 ' log_website_daffainfo.log > "$root"/forensic_log_website_daffainfo_log/result.txt

#2d
awk 'BEGIN {FS=":";n=0;}
/curl/ {++n} #cek curl tiap row, lalu di count
END {
  print "Ada", n, "requests yang menggunakan curl sebagai user-agent\n"
}
 ' log_website_daffainfo.log >> "$root"/forensic_log_website_daffainfo_log/result.txt

#2e
awk 'BEGIN {FS=":";}
{
 if(NR>1 && $2~"22/Jan/2022:02"){ #cari string yang memuat 22/Jan/2022:02
  ip[$1]=ip[$1]+1
 }
}
END {
  for(hasil in ip) printf("%s\n", hasil)
}
 ' log_website_daffainfo.log >> "$root"/forensic_log_website_daffainfo_log/result.txt
