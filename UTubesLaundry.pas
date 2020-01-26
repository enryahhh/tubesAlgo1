program laundry;
uses crt;
const maks = 20;
      namafile='dataLaundry.dat';
type
    TLaundry=record
                   nama:string[20];
                   nik:string[16];
                   alamat:string[30];
                   paket:string;
                   berat:integer;
                   harga:real;
             end;
      TArrayLaundry=array[1..maks] of TLaundry;

procedure menu(var pilihan:integer);
begin
    clrscr;
     writeln('-----------------------------------');
     writeln('Laundry BULE');
     writeln('-----------------------------------');
     writeln('1. Tambah Transaksi');
     writeln('2. View Transaksi');
     writeln('3. Cari Data');
     writeln('0. Keluar');
     writeln('-----------------------------------');
     write('Pilihan anda : ');readln(pilihan);
end;

procedure addTransaksi(var transaksi:TArrayLaundry;var banyakdata:integer);
var
   pilihPaket:integer;
begin
     clrscr;
     if banyakdata<maks then
     begin
          banyakdata:=banyakdata+1;
          writeln('-----------------------------------');
          writeln('List Paket');
          writeln('1.Express (8 jam) Rp 15000/Kg');
          writeln('2.Normal   (2 hari) Rp 7000/Kg');
          writeln('-----------------------------------');
          writeln('Masukan data transaksi ke-',banyakdata);
          write('Nama   : ');readln(transaksi[banyakdata].nama);
          write('NIK    : ');readln(transaksi[banyakdata].nik);
          write('Alamat : ');readln(transaksi[banyakdata].alamat);
          write('Paket  : ');readln(pilihPaket);
          write('Berat  : ');readln(transaksi[banyakdata].berat);
          if(pilihPaket = 1) then
               begin
               transaksi[banyakdata].harga := 15000*transaksi[banyakdata].berat;
               transaksi[banyakdata].paket:='Express';
               end
          else
              begin
             transaksi[banyakdata].harga := 7000*transaksi[banyakdata].berat;
             transaksi[banyakdata].paket:='Normal';
             end;
          writeln('Total Harga  : ',transaksi[banyakdata].harga:0:2);
     end;
       writeln('Tekan sembarang tombol untuk melanjutkan');readkey;
end;

function searchByName(transaksi:TArrayLaundry;banyakdata:integer;dicari:string):integer;
var
   i:integer;
begin
   i:=1;
   while(pos(upcase(dicari),upcase(transaksi[i].nama))=0) and (i<banyakdata) do
        i:=i+1;
   if(pos(upcase(dicari),upcase(transaksi[i].nama))<>0) then
      searchByName:=i
   else
       searchByName:=0;
end;

procedure searchName(transaksi:TArrayLaundry;banyakdata:integer);
var
  nama:string;
  posisiData:integer;
begin
     clrscr;
     write('Nama Yang Dicari : ');readln(nama);
     posisiData:=searchByName(transaksi,banyakdata,nama);
     if posisidata<>0 then
        begin
        writeln('Data di Temukan');
        writeln('Nama         : ',transaksi[posisiData].nama);
        writeln('NIK          : ',transaksi[posisiData].nik);
        writeln('Alamat       : ',transaksi[posisiData].alamat);
        writeln('Paket        : ',transaksi[posisiData].paket);
        writeln('Berat        : ',transaksi[posisiData].berat);
        writeln('Total Harga  : RP ',transaksi[posisiData].harga:0:2);
      end
      else
          writeln('Data Tidak Ditemukan');
      writeln('Tekan Enter untuk melanjutkan');readln;
end;

procedure viewTransaksi(transaksi:TArrayLaundry;banyakdata:integer);
var
   i:integer;
begin
     clrscr;
     writeln('Data Transaksi Laundry');
     writeln('----------------------------------------------------------------------------------------------------------------');
     writeln('|        NAMA          |       NIK        |           Alamat               |  Paket  |   Berat  |     Harga     |');
     writeln('----------------------------------------------------------------------------------------------------------------');
     {
      0000000001111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990000000000111111111222222222
      1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
      | 12345678901234567890 | 1234567890123456 | 123456789012345678901234567890 | 1234567 | 1234567 | 1234567890123 |
      |        NAMA          |       NIK        |           Alamat               |  Paket  |  Berat  |     Harga     |

     }
     for i:=1 to banyakdata do
     begin
         gotoxy(1,i+4);write('|                      |                  |                                |         |          |               |');
         gotoxy(3,i+4);write(transaksi[i].nama);
         gotoxy(26,i+4);write(transaksi[i].nik);
         gotoxy(46,i+4);write(transaksi[i].alamat);
         gotoxy(78,i+4);write(transaksi[i].paket);
         gotoxy(88,i+4);write(transaksi[i].berat,' Kg');
         gotoxy(98,i+4);writeln('Rp ',transaksi[i].harga:0:2);
     end;
     writeln('----------------------------------------------------------------------------------------------------------------');
     writeln('Tekan sembarang tombol untuk melanjutkan');readkey;
end;

procedure saveToFile(transaksi:TArrayLaundry;banyakdata:integer);
var
   f:file of TLaundry;
   i:integer;
begin

    assign(f,namafile);
    rewrite(f);
    for i:= 1 to banyakdata do
        write(f,transaksi[i]);
    close(f);
end;

procedure readFromFile(var transaksi:TArrayLaundry;banyakdata:integer);
var
  f:file of TLaundry;
begin
     assign(f,namafile);
     reset(f);
     if IOResult <> 0 then
        rewrite(f);
     while not eof(f) do
     begin
         banyakdata:=banyakdata+1;
         read(f,transaksi[banyakdata]);
     end;
     close(f);

end;

var
    transaksi:TArrayLaundry;
    banyakdata:integer;
    pilihan:integer;
    perubahan:boolean;
    simpan:char;
begin
     banyakdata:=0;
     perubahan:=false;
     readFromFile(transaksi,banyakdata);
     repeat
           menu(pilihan);
           if pilihan=1 then
           begin
                addTransaksi(transaksi,banyakdata);
                perubahan:=true;
           end
           else
           if pilihan=2 then
               viewTransaksi(transaksi,banyakdata)
           else
           if pilihan=3 then
              searchName(transaksi,banyakdata);
     readkey;

     until pilihan=0;
     if perubahan = true then
        begin
          writeln('Telah Terjadi Perubahan ' );
          write('Apakah data mau di simpan ? ');readln(simpan);
          if upcase(simpan)='Y' then
             saveToFile(transaksi,banyakdata);
        end;

end.
