create database Aptech
go

use Aptech
go

create table Classes(
			ClassName char(6),
			Teacher varchar(30),
			TimeSlot varchar(30),
			Class int,
			Lab int
)
go

--Tạo unique clustered index (MyClusteredIndex) {thuộc tính}
create unique clustered index MyClusteredIndex
	on Classes(ClassName) with
	{
	pad_index=on,
	fillfactor=70,
	ignore_dup_key=on
	};
go
/* pad_index là công tắc để bật/tắt fill factor (fillfactor chỉ quy định số %)
	ignore_dup_key chuyển on để từ chối việc nhập các giá trị trùng nhau/đã có trước vào bảng */
--Tạo non clustered index (TeacherIndex)
create nonclustered index TeacherIndex
	on Classes(Teacher);
go

--Xóa (drop) TeacherIndex
drop index TeacherIndex on Classes(Teacher)

create unique clustered index MyClusteredIndex
	on Classes(ClassName) with
	{
	drop_existing=on,
	allow_row_locks=on,
	allow_page_locks=on,
	maxdop=2
	};
go
--drop existing=on <=> drop index nếu đã trùng tên, index tạo mới cùng tên sẽ thay thuộc tính trong {}
--allow row/page locks đặt on => index này cho phép lock các object (row/page) tương ứng
-- ---- Lock