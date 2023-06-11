create database QLDSV 
go

use QLDSV

--Tạo cơ sở dữ liệu QLDSV (Quản lý điểm sinh viên) có các bảng:
create table sv(
masv varchar(10) primary key,hodem nvarchar(30),ten nvarchar(10),
ngaysinh date,gioitinh bit,noisinh nvarchar(30),quequan nvarchar(30),
diachi nvarchar(200),sdt varchar(11),diemdauvao float,doituong nvarchar(30),khuvuc varchar(1)
)

create table monhoc(
mamon varchar(10) primary key,tenmon nvarchar(15),sotinchi int,hocky int
)

create table diem(
masv varchar(10) primary key,mamon varchar(10),diem float
foreign key(masv) references sv(masv),
foreign key(mamon) references monhoc(mamon)
)
--cau 1. Đưa ra Họ đệm, Tên, Nơi sinh, Tên môn mà học sinh đã học với số tín chỉ của môn lớn hơn 3 và sắp xếp theo thứ tự giảm dần của cột số tín chỉ, tăng dần của tên môn.
select sv.hodem, sv.ten,sv.noisinh,monhoc.tenmon from sv,monhoc,diem
where sv.masv=diem.masv and monhoc.mamon=diem.mamon and monhoc.sotinchi>2  ORDER BY hocky DESC,tenmon ASC

--cau 2.Đưa ra Họ đệm, Tên, Tên môn, Điểm của những học sinh có điểm là 1 hoặc 2 hoặc 9 hoặc 10 và các môn đó có số tín chỉ lớn hơn hoặc bằng 4.
select sv.hodem, sv.ten,monhoc.tenmon,diem.diem from sv,monhoc,diem
where sv.masv=diem.masv and monhoc.mamon=diem.mamon and diem=9 and sotinchi>=3

--cau 3.Đưa ra giới tính và số lượng sinh viên tương ứng
select sv.gioitinh,count(sv.masv)as sLSinhVien from sv
group by gioitinh

--cau 4.Đưa ra Họ đệm, Tên, Ngày sinh, Nơi sinh, Tên môn, Điểm của những học sinh có nơi sinh không phải là Hà Nội và điểm lớn hơn 8.
select sv.hodem, sv.ten,sv.noisinh,monhoc.tenmon,diem.diem from sv,monhoc,diem
where sv.masv=diem.masv and monhoc.mamon=diem.mamon and noisinh <>'ha noi' and diem>7

--cau 5.Đưa ra họ tên sinh viên nữ có điểm đầu vào nằm trong khoảng từ 20 đến 25 và đối tượng là 5 hoặc 6 hoặc 7
select sv.hodem, sv.ten from sv
where gioitinh = 'true' and diemdauvao >7 and doituong = 'uu tien'

--cau 6.Đưa ra họ tên, ngày sinh những sinh viên sinh vào quý II của năm 2004
select hodem,ten,ngaysinh from sv
where MONTH(ngaysinh)= 6 or MONTH(ngaysinh)= 4 or MONTH(ngaysinh)= 5 and year(ngaysinh)=2002

--cau 7.Đưa ra họ tên, tuổi những sinh viên có tuổi không thuộc từ 24 đến 27
select hodem,ten,YEAR(getdate()) - YEAR(ngaysinh) as tuoi from sv
where YEAR(getdate()) - YEAR(ngaysinh) >=20 and YEAR(getdate()) - YEAR(ngaysinh) <=27

--cau 8.Đưa ra mức điểm đầu vào cao nhất
select max(diemdauvao) as diemDauVaoCaoNhat from sv

--cau 9.Đưa ra danh sách 5 sinh viên có điểm đầu vào cao nhất
select top 5 * from sv
ORDER BY diemdauvao DESC

--cau 10.Đưa ra danh sách tỉnh thành mà sinh viên có nơi sinh ở đó. (không kể trùng lại)
select DISTINCT noisinh from sv

--cau 11.Đưa ra đối tượng và số lượng sinh viên tương ứng
select doituong,count(sv.masv)as sLSinhVien from sv
group by doituong

--cau 12.Đưa ra Họ đệm, Tên, Ngày sinh, Tuổi của những học sinh có tên bắt đầu bằng chữ A đã học môn Tin và có điểm nhỏ hơn điểm trung bình của môn đó.
select hodem,ten,ngaysinh,YEAR(getdate()) - YEAR(ngaysinh) as tuoi from sv,diem,monhoc
where sv.masv=diem.masv and monhoc.mamon=diem.mamon and ten like 'A%' and tenmon='Tin' and diem.diem>sv.diemdauvao