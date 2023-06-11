create database truong

use truong
go

create table hs(
Mahs varchar(10) primary key,hodem nvarchar(30),ten nvarchar(15),ngaysinh date,noisinh nvarchar(20),diemdauvao float
)
--2.Tạo thủ tục để nhập dữ liệu vào bảng trên.
create proc them(@Mahs varchar(10),@hodem nvarchar(30),@ten nvarchar(15),@ngaysinh date,@noisinh nvarchar(20),@diemdauvao float)
as
begin
insert hs values(@Mahs,@hodem,@ten,@ngaysinh,@noisinh,@diemdauvao)
end

exec them 'hs01','hihi','haha','2003-11-03','bac ninh',6
--3. Viết thủ tục đưa ra thông tin về những học sinh có điểm đầu vào bằng oặc lớn hơn số điểm của người dùng đưa ra.
create proc duara(@diemhs float)
as
begin
select * from hs where diemdauvao >= @diemhs
end

exec duara 7

--4. Xóa những học sinh có điểm đầu vào nhỏ hơn điểm do người dùng đưa ra.
create proc xoa(@diemhs float)
as
begin
DELETE FROM hs WHERE diemdauvao<@diemhs
end

exec xoa 7

--5. Viết thủ tục sửa lại nơi sinh theo yêu cầu của người dùng cho học sinh có mã theo người dùng đưa ra
create proc sua(@mahs varchar(10),@noisinh nvarchar(20))
as
begin
UPDATE hs SET noisinh=@noisinh WHERE Mahs=@mahs;
end

exec sua SV05,'BAC NINH'

--6. Tìm ước số chung lớn nhất của 2 số nhập vào.
alter PROCEDURE find_gcd(@num1 INT, @num2 INT)
AS
BEGIN
    DECLARE @gcd INT;
    DECLARE @temp INT;

    SET @gcd = @num1;

    WHILE @num2 != 0
    BEGIN
        SET @temp = @num2;
        SET @num2 = @gcd % @num2;
        SET @gcd = @temp;
    END;

    SELECT @gcd AS uocchunglonnhat;
END;

exec find_gcd 10,15

--7. Viết thủ tục đưa ra số ngày của tháng.
create proc SoNgayTrongThang(@SoThang int, @SoNam int)
as
begin
declare @SoNgay int
if @SoThang <1 and @SoThang >12
	print 'Ban nhap sai thang'
else
	begin 
	set @SoNgay =
	case
		when @SoThang in(1,3,5,7,8,10,12) then 31
		when @SoThang in(4,6,9,11) then 30
		when (@SoThang =2) and (@SoNam %4 =0) then 29
		else 28
	end
	end
print 'So ngay trong thang ' +cast(@SoThang as varchar(5)) +' la ' + cast (@SoNgay as varchar(5)) + ' ngay'
end

exec SoNgayTrongThang 10, 2003

--8. Thủ tục:
--a) Viết thủ tục kiểm tra n có phải là số hoàn hảo không
--b) Viết thủ tục kiểm tra n có phải là số nguyên tố không
--c) Viết thủ tục đưa ra các ước của n.
--d) Viết thủ tục tìm các số nguyên tố nhỏ hơn n
--e) Nhập vào 2 số đưa ra bội số chung nhỏ nhất của 2 số đó.
--f) Viết một thủ tục nhập vào 2 số ở dạng tử số và mẫu số sau đó đưa ra phân số tối giản.
 
alter PROCEDURE CheckPerfectNumber(@num INT)
as
BEGIN
--a) Viết thủ tục kiểm tra n có phải là số hoàn hảo không
    DECLARE @sum_divisors INT;
    DECLARE @is_perfect INT;
    SET @sum_divisors = 0;
    
    IF @num > 1 
	begin
        DECLARE @i INT = 1;
        
        WHILE @i <= @num / 2
		begin
            IF @num % @i = 0 
			begin
                SET @sum_divisors = @sum_divisors + @i;
            END
            SET @i = @i + 1;
        END 
    END
	if @sum_divisors = @num
    begin
	print 'n la so hoan hao'
	end
	else
	begin 
	print 'n la ko so hoan hao'
	end
--b) Viết thủ tục kiểm tra n có phải là số nguyên tố không
CREATE PROCEDURE CheckPrimeNumber(IN num INT, OUT is_prime BOOLEAN)
BEGIN
    DECLARE i INT;
    DECLARE is_divisible BOOLEAN DEFAULT FALSE;
    
    SET i = 2;
    
    WHILE (i <= FLOOR(SQRT(num))) DO
        IF (num % i = 0) THEN
            SET is_divisible = TRUE;
            LEAVE;
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    SET is_prime = NOT is_divisible;
END //
END 
--e tìm bội chung nhỏ nhất
CREATE PROCEDURE FindLeastCommonMultiple(IN num1 INT, IN num2 INT, OUT lcm INT)
BEGIN
    DECLARE larger_num INT;
    DECLARE i INT;

    IF num1 > num2 THEN
        SET larger_num = num1;
    ELSE
        SET larger_num = num2;
    END IF;

    SET i = larger_num;

    WHILE TRUE DO
        IF i % num1 = 0 AND i % num2 = 0 THEN
            SET lcm = i;
            LEAVE;
        END IF;

        SET i = i + larger_num;
    END WHILE;
END //
