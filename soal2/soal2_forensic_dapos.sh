#!/bin/bash

root=/home/fidhiaaka/praktikum2

#2a
mkdir "$root"/forensic_log_website_daffainfo_log

#2b

#2c
awk 'BEGIN {FS=":";max=0;ipmax="";}
{
  if(NR>1){
    a[$1]++
  }
}
END {
  max=0
  ipmax=""
  for (b in a){
    if(a[b]>max){ #cek tiap IP dengan banyak request
      ipmax=b
      max=a[b]
    }
  }
  print "IP yang paling banyak mengakses server adalah:", ipmax, "sebanyak", max, "requests\n"
}
 ' log_website_daffainfo.log > "$root"/forensic_log_website_daffainfo_log/result.txt

#2d
awk 'BEGIN {FS=":";n=0;}
/curl/ {++n}
END {
  print "Ada", n, "requests yang menggunakan curl sebagai user-agent\n"
}
 ' log_website_daffainfo.log >> "$root"/forensic_log_website_daffainfo_log/result.txt
