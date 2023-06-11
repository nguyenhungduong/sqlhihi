create database QLDuan

use QLDuan

create table nhanvien(
manv varchar(10) primary key,hodem nvarchar(30),ten nvarchar(10),
ngaysinh date,gioitinh bit
)

create table duan(
mada varchar(10) primary key,tenda nvarchar(30),diadiemda nvarchar(30)
)

create table nvvads(
manv varchar(10),mada varchar(10),Sogiocong tinyint
foreign key(manv) references nhanvien(manv),
foreign key(mada) references duan(mada)
)
alter table nhanvien add luong int

--2. Đưa ra Họ đệm, Tên nhân viên có lương cao nhất.
select hodem,ten from nhanvien
where luong = (select max(luong) from nhanvien)

--3. Đưa ra Họ đệm, Tên, Giới tính, Lương của các nhân viên nữ và có lương từ 3 triệu đến 5 triệu.
select hodem,ten,gioitinh,luong from nhanvien
where gioitinh='0' and luong >300000 and luong <500000

--4. Đưa ra Họ đệm, Tên, Giới tính, Ngày sinh, Tên dự án, Địa điểm dự án của những nhân viên nam và số giờ công nhỏ hơn 30 và sắp xếp theo thứ tự giảm dần của số giờ công.
select hodem,ten,gioitinh,ngaysinh,tenda,diadiemda from nhanvien,duan,nvvads
where nhanvien.manv=nvvads.manv and duan.mada=nvvads.mada and gioitinh='1' and  Sogiocong<30 order by Sogiocong desc

--5. Đưa ra Họ đệm, Tên, Giới tính, Ngày sinh, Lương, Địa điểm dự án, Số giờ công của những nhân viên sinh trong quý II năm 1981 và có lương nhỏ hơn mức lương trung bình.
select hodem,ten,gioitinh,ngaysinh,luong,diadiemda,Sogiocong from nhanvien,duan,nvvads
where nhanvien.manv=nvvads.manv and duan.mada=nvvads.mada and luong< (select AVG(luong) from nhanvien ) and year(ngaysinh) = 1981 and MONTH(ngaysinh) in(1,2,3)

--6. Đưa ra Họ đệm, Tên, Ngày sinh, Lương, Tên dự án, Số giờ công của những nhân viên có tên bắt đầu bằng chữ T và số giờ công lớn hơn 20, địa điểm của dự án nviên tham gia là Hà Nội.
select hodem,ten,gioitinh,ngaysinh,luong,tenda,Sogiocong from nhanvien,duan,nvvads
where nhanvien.manv=nvvads.manv and duan.mada=nvvads.mada and nhanvien.ten like 'T%' and Sogiocong>20 and diadiemda='ha noi'

--7. Sửa lại lương cho nhân viên có mã NV41 để nhân viên này có cùng mức lương với nhân viên có mã NV82
update nhanvien set luong=(select luong from nhanvien where manv='NV01' ) where manv='NV04'

--8. Có bao nhiêu nhân viên nữ tham gia dự án có số giờ công từ 30 đến 100.
select COUNT(nhanvien.manv) as soluongnhanvien from nhanvien,duan,nvvads
where nhanvien.manv=nvvads.manv and duan.mada=nvvads.mada and gioitinh='0' and Sogiocong>30 and Sogiocong<100

--9. Tính tổng số tiền mà nhân viên có tên lan được lĩnh biết đơn giá giờ công là 50000.
select sum(Sogiocong *50000) as tongsotien from nhanvien,nvvads
where nhanvien.manv=nvvads.manv and ten='dung'

--10.Xóa nhân viên có mức lương thấp nhất.
delete from nhanvien where luong=(select min(luong) from nhanvien)

--11.Đưa ra Tên, Lương, ngày sinh, tuổi của các nhân viên nam và có lương không năm trong khoảng từ 4 triệu đến 5 triệu.
select ten,luong,ngaysinh,year(getdate())- year(ngaysinh) as tuoi from nhanvien
where gioitinh='1' and luong >4000000 and luong <5000000

--12.Đưa ra Tên, Giới tính, Ngày sinh, Tên dự án, Địa điểm dự án của những nhân viên nam và số giờ công từ 30 đến 100 và sắp xếp theo thứ tự tăng của số giờ công.
select ten,gioitinh,ngaysinh,tenda,diadiemda,Sogiocong from nhanvien,duan,nvvads
where nhanvien.manv=nvvads.manv and duan.mada=nvvads.mada and gioitinh='1' and  Sogiocong>30  and Sogiocong<100 order by Sogiocong asc


