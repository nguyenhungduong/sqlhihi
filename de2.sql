create database QLKS2
create table KhachHang(
MaKh varchar(10) primary key,
HoDem nvarchar(50),
Ten nvarchar(10),
GioiTinh bit,
DiaChi nvarchar(50),
DienThoai varchar(10)
)
create table Phong(
MaPhong varchar(10)primary key,
TenPhong nvarchar(50),
LoaiPhong nvarchar(30),
Gia float
)
create table ThanhToan(
MaChungTu varchar(10) primary key,
MaKh varchar(10) foreign key (MaKh) references KhachHang (MaKh),
MaPhong varchar(10) foreign key (MaPhong) references Phong (MaPhong),
NgayDen date,
NgayDi date
)
Insert into KhachHang
values('KH01','Nguyen Van','A',0,'BacNinh','0123456789'),
('KH02','Nguyen Van','B',0,'HaNoi','0126789345'),
('KH03','Tran Van','C',0,'HaiPhong','0456789123'),
('KH04','Nguyen Thi','H',1,'TuyenQuang','0789123456'),
('KH05','Tran Thi','K',1,'BacGiang','0127893456')
Insert into KhachHang
values('KH06','Nguyen Van','hihi',0,'HaiDuong','0123456788')
Insert into Phong
values('P01','203','Thuong',3000),
('P02','205','Don',5000),
('P03','402','Vip',10000),
('P04','333','Don',8100),
('P05','501','Doi',9600)
Insert into ThanhToan
values('CT01','KH01','P01','2023/2/5','2023/2/7'),
('CT02','KH02','P02','2023/5/5','2023/5/7'),
('CT03','KH03','P03','2023/3/5','2023/6/7'),
('CT04','KH04','P04','2023/2/7','2023/2/8'),
('CT05','KH05','P05','2023/4/5','2023/6/7')
Insert into ThanhToan
values('CT06','KH01','P04','2023/8/5','2023/2/7')
Insert into ThanhToan
values('CT10','KH04','P05','2023/6/6','2023/4/9')
--Cau1. Đưa ra giới tính và số lượng khách hàng tương ứng.
select GioiTinh, COUNT(GioiTinh) as SlgKh
from KhachHang
group by GioiTinh
--Cau2. Đưa ra loại phòng, tổng đơn giá tương ứng của loại phòng đó.
select LoaiPhong ,SUM(Gia) as GiaPhong
from Phong
group by LoaiPhong
--Cau3. Đưa ra Mã phòng, Tên phòng, Giá của những phòng có giá lớn hơn mức giá trung bình và sắp xếp theo chiều giảm dần của mức giá, tăng dần của mã phòng.
select MaPhong, TenPhong, Gia
from Phong
where Gia > (select AVG(Gia) from Phong)
ORDER BY Gia DESC, MaPhong ASC
--Cau4. Đưa ra 10 phòng có mức giá thấp nhất
select top 10 Gia , MaPhong, TenPhong, LoaiPhong
from Phong
order by Gia ASC
--Cau5. Đưa ra Họ đệm, Tên, Giới tính, Địa chỉ, Ngày đến của những khách hàng có họ là Nguyễn và đến thuê phòng vào quý III của năm 2006
select HoDem, Ten, GioiTinh, NgayDen
from KhachHang kh ,ThanhToan tt
where tt.MaKh= kh.MaKh and kh.HoDem Like '%Nguyen%' and MONTH(NgayDen) in(7,8,9) and YEAR(NgayDen) = 2006
--Cau6. Đưa ra họ tên khách hàng nam mà tên có ký tự thứ 2 là i
select HoDem, Ten, GioiTinh
from KhachHang
where GioiTinh = 0 and Ten like '_i%'
--Cau7. Đưa ra Họ đệm, Tên, Giới tính, Địa chỉ, Giá phòng, Ngày đến, Ngày trả, Số ngày thuê, Tiền thuê.
select HoDem, Ten, GioiTinh, DiaChi, NgayDen,NgayDi, DATEDIFF(day, ThanhToan.NgayDen, ThanhToan.NgayDi) AS NgayThue,(DATEDIFF(day, ThanhToan.NgayDen, ThanhToan.NgayDi) * Gia)as TienThue
from KhachHang, Phong, ThanhToan
where ThanhToan.MaKh=KhachHang.MaKh and ThanhToan.MaPhong=Phong.MaPhong
--Cau8
select MIN(Gia) as Muc_Gia_Thap_Nhat
from Phong
--Cau9
select TenPhong 
from Phong
where Gia = (select MAX(Gia) 
from Phong)
--Cau10. Đưa ra Họ đệm, Tên, Giới tính, Địa chỉ, Giá phòng, Ngày đến, Ngày trả, Giá phòng 
--với mức giá thuê nhỏ hơn 500 nghìn và khách hàng là nữ, Ngày trả là tháng 12 năm 2005.
select HoDem, Ten, GioiTinh, DiaChi, Gia, NgayDen, NgayDi 
from Phong, KhachHang,ThanhToan
where ThanhToan.MaKh=KhachHang.MaKh and ThanhToan.MaPhong=Phong.MaPhong 
and GioiTinh =1 and Gia <9000 and MONTH(NgayDi) =2 and YEAR(NgayDi) =2023
--Cau11. Đếm xem có bao nhiêu khách hàng nữ sinh nhật vào các tháng 3 và 10
select COUNT(MaKh) as SlgKh
from KhachHang
where GioiTinh ='1' and MONTH(NgaySinh) in(3,10)
--Cau12. Hãy dùng lệnh để sửa tại bảng Khách hàng cho khách hàng có mã KH03 với các thông tin mới là Địa chỉ: Hà Nam; Điện thoại: 0912999511
update KhachHang set DiaChi ='Ha Nam', DienThoai= '0912999511'
where MaKh ='KH03'
--Cau13. Sửa lại giá phòng cho phòng có mã P2404 để phòng này có cùng giá với phòng có mã P2412
update Phong set Gia = (select Gia from Phong where MaPhong ='P2412')
where MaPhong = 'P2412'
--Cau14. Đưa ra thông tin giá phòng và số lượng phòng có giá đó.
select Gia, COUNT(Gia) as SlgPhong
from Phong
group by Gia
--Cau15. Tính tổng doanh thu của khách sạn trong tháng hiện tại
select SUM(DATEDIFF(day, ThanhToan.NgayDen, ThanhToan.NgayDi) * Gia) as DoanhThu
from ThanhToan,Phong,KhachHang
where MONTH(NgayDen) = MONTH(GETDATE()) and YEAR (NgayDen) = YEAR(GETDATE())



