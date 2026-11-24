program TabelKebenaranLogika;

uses crt;

type
  TabelNilai = array[1..8] of Boolean;

var
  p, q, r: Boolean;
  a, b, c: Boolean;
  hasil, hasil2: Boolean;
  kolom1, kolom2: TabelNilai;
  i, n, jumlahBaris, pilihan: Integer;
  benar, salah: Integer;
  adaEkuivalensi: Boolean;

function Implikasi(x, y: Boolean): Boolean;
begin
  Implikasi := (not x) or y;
end;

function Biimplikasi(x, y: Boolean): Boolean;
begin
  Biimplikasi := (x = y);
end;

procedure TampilNilai(x: Boolean);
begin
  if x then
    write('B')
  else
    write('S');
end;

procedure TampilJudul;
begin
  writeln;
  writeln('==============================================');
  writeln('       PROGRAM TABEL KEBENARAN LOGIKA');
  writeln('==============================================');
end;

procedure Klasifikasi;
begin
  writeln;
  writeln('HASIL KLASIFIKASI:');

  if benar = jumlahBaris then
    writeln('Jenis Ekspresi : TAUTOLOGI')
  else if salah = jumlahBaris then
    writeln('Jenis Ekspresi : KONTRADIKSI')
  else
    writeln('Jenis Ekspresi : KONTINGENSI');
end;

begin
  clrscr;

  repeat
    TampilJudul;

    writeln('PILIH MATERI / SOAL:');
    writeln;
    writeln('1.  p OR NOT q');
    writeln('2.  (p -> q) AND (q -> p)');
    writeln('3.  p AND NOT p');
    writeln('4.  (p -> q) OR (q -> p)');
    writeln('5.  Hukum De Morgan');
    writeln('6.  (p OR q) -> (p AND r)');
    writeln('7.  Uji Kontraposisi');
    writeln('8.  Hukum Absorpsi');
    writeln('9.  a AND NOT (b OR c)');
    writeln('10. Uji Ekuivalensi Implikasi');
    writeln;
    writeln('11. Contoh Tautologi');
    writeln('12. Contoh Kontradiksi');
    writeln('13. Contoh Kontingensi');
    writeln('14. Contoh Kontrol Akses');
    writeln('15. Keluar');
    writeln;

    write('Masukkan pilihan: ');
    readln(pilihan);

    if (pilihan >= 1) and (pilihan <= 15) then
    begin
      if pilihan = 15 then
        break;

      if (pilihan = 6) or (pilihan = 9) or
         (pilihan = 10) or (pilihan = 14) then
        n := 3
      else
        n := 2;

      jumlahBaris := 1;

      for i := 1 to n do
        jumlahBaris := jumlahBaris * 2;

      benar := 0;
      salah := 0;
      adaEkuivalensi := false;

      if (pilihan = 2) or (pilihan = 5) or
         (pilihan = 7) or (pilihan = 8) or
         (pilihan = 10) then
        adaEkuivalensi := true;

      writeln;
      writeln('JUMLAH VARIABEL : ', n);
      writeln('JUMLAH BARIS    : 2^', n, ' = ', jumlahBaris);
      writeln;

      if n = 2 then
        writeln('p     q     HASIL P     HASIL Q')
      else
        writeln('p     q     r     HASIL P     HASIL Q');

      writeln('----------------------------------------------');

      for i := 0 to jumlahBaris - 1 do
      begin
        p := ((i div (jumlahBaris div 2)) mod 2) = 0;
        q := ((i div (jumlahBaris div 4)) mod 2) = 0;

        if n = 3 then
          r := (i mod 2) = 0;

        hasil := false;
        hasil2 := false;

        case pilihan of

          1:
            hasil := p or (not q);

          2:
            begin
              hasil := Implikasi(p,q) and Implikasi(q,p);
              hasil2 := Biimplikasi(p,q);
            end;

          3:
            hasil := p and (not p);

          4:
            hasil := Implikasi(p,q) or Implikasi(q,p);

          5:
            begin
              hasil := not (p or q);
              hasil2 := (not p) and (not q);
            end;

          6:
            hasil := Implikasi(p or q, p and r);

          7:
            begin
              hasil := Implikasi(p,q);
              hasil2 := Implikasi(not q,not p);
            end;

          8:
            begin
              hasil := p and (p or q);
              hasil2 := p;
            end;

          9:
            hasil := p and (not (q or r));

          10:
            begin
              hasil := Implikasi(p and q,r);
              hasil2 := Implikasi(p,Implikasi(q,r));
            end;

          11:
            hasil := Implikasi(p and q,p);

          12:
            hasil := (p or q) and ((not p) and (not q));

          13:
            hasil := Implikasi(p or q,p and q);

          14:
            hasil := p and (q or r);

        end;

        kolom1[i+1] := hasil;
        kolom2[i+1] := hasil2;

        if n = 2 then
        begin
          TampilNilai(p);
          write('     ');
          TampilNilai(q);
          write('       ');
        end
        else
        begin
          TampilNilai(p);
          write('     ');
          TampilNilai(q);
          write('     ');
          TampilNilai(r);
          write('       ');
        end;

        TampilNilai(hasil);

        if adaEkuivalensi then
        begin
          write('           ');
          TampilNilai(hasil2);
        end;

        writeln;

        if hasil then
          benar := benar + 1
        else
          salah := salah + 1;
      end;

      Klasifikasi;

      if adaEkuivalensi then
      begin
        writeln;
        writeln('HASIL UJI EKUIVALENSI:');

        for i := 1 to jumlahBaris do
        begin
          if kolom1[i] <> kolom2[i] then
          begin
            writeln('Kedua ekspresi TIDAK EKUIVALEN.');
            break;
          end;
        end;

        if i > jumlahBaris then
          writeln('Kedua ekspresi EKUIVALEN.');
      end;

      writeln;
      writeln('Jumlah Benar (B) : ', benar);
      writeln('Jumlah Salah (S) : ', salah);
      writeln;
      write('Tekan ENTER untuk kembali ke menu...');
      readln;
      clrscr;
    end
    else
    begin
      writeln('Pilihan tidak tersedia!');
      readln;
      clrscr;
    end;

  until pilihan = 15;

  clrscr;
  writeln('==============================================');
  writeln('     TERIMA KASIH TELAH MENGGUNAKAN PROGRAM');
  writeln('==============================================');
  readln;
end.
