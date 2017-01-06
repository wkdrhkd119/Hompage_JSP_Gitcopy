drop table address

create table address(
	no			number(6)			not null,
	name		varchar(20)		not null,
	phone		varchar(20)		not null,
	zipcode		varchar(6)		not null,
	address1	varchar(200)	not null,
	address2	varchar(100)	not null,
	wdate		date			not null,
	primary key(no)
)

SELECT * from address


---일련번호
SELECT nvl(max(no),0)+1 from address


---insert
insert into address(no, name, phone, zipcode, address1, address2, wdate)
values((select nvl(max(no),0)+1 from address),'가동', '010-1111-2222', '12345', '서울시 종로구', '코아빌딩', sysdate)

insert into address(no, name, phone, zipcode, address1, address2, wdate)
values((select nvl(max(no),0)+1 from address),'김사장', '010-1111-2222', '12345', '서울시 종로구', '코아빌딩', sysdate)


---updat
update address set name='이이이', phone='010-9632-8741', zipcode='5555'
where no = 5


--read
select no, name, phone, zipcode from address 


---list
select no, name, phone, zipcode, wdate, r
from(
	select no, name, phone, zipcode, wdate, rownum r
		from(
		select no, name, phone, zipcode, wdate 
		from address 
		where name like '%수정%'
		order by no desc
		)
	)where r>=1 and r<=5
	
select count(*) from address
where name like '%수정%'

---delete
delete from ADDRESS where no = 6



