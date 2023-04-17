#!/bin/bash

# Mengecek apakah program dijalankan sebagai root
if [[ $EUID -ne 0 ]]; then
   echo "Program harus dijalankan sebagai root!" 
   exit 1
fi

# Mengecek apakah argumen yang diberikan valid
if [[ $# -ne 2 ]]; then
   echo "Gunakan program ini dengan benar: $0 [asal] [tujuan]" 
   exit 1
fi

# Menyimpan direktori asal dan tujuan dari argumen
asal=$1
tujuan=$2

# Mengecek apakah direktori asal dan tujuan benar-benar ada
if [[ ! -d $asal ]]; then
   echo "Direktori asal tidak ditemukan!" 
   exit 1
fi

if [[ ! -d $tujuan ]]; then
   echo "Direktori tujuan tidak ditemukan!" 
   exit 1
fi

# Menghitung jumlah file di direktori asal
jumlah=$(ls -l $asal | grep -v ^d | wc -l)

# Menampilkan pesan konfirmasi
echo "Anda akan menyalin $jumlah file dari $asal ke $tujuan. Lanjutkan? (y/n)"
read confirm

# Mengecek apakah pengguna ingin melanjutkan atau tidak
if [[ $confirm != "y" ]]; then
   echo "Program dihentikan oleh pengguna."
   exit 0
fi

# Menyalin file dari direktori asal ke direktori tujuan
for file in $asal/*
do
   if [[ -f $file ]]; then
      cp $file $tujuan
   fi
done

echo "Penyalinan selesai."
