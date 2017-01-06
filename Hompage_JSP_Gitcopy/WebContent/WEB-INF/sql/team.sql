create table team(
	no			number			not null,
	name		varchar(20)		not null,
	gender		varchar(5)		not null,
	phone 		varchar(20)		not null,
	zipcode		varchar(6)		not null,
	address1	varchar(100)	not null,
	address2	varchar(100)	not null,
	skill		varchar(50)		not null,
	hobby		varchar(50)		not null,
	filename	varchar(50)		default 'member.jpg',
	primary key(no)
)

select nvl(max(no),0)+1 from team

insert into team(no, name, gender, phone, zipcode, address1, address2, skill, hobby, filename)
values((select nvl(max(no),0)+1 from team), '홍길동', '남', '010-1111-1111', '12345', 
		'서울시 종로구', '코아빌딩', 'JAVA,JSP,SQL', '독서','member.jpg')
		
insert into team(no, name, gender, phone, zipcode, address1, address2, skill, hobby, filename)
values((select nvl(max(no),0)+1 from team), '홍길동', '남', '010-2222-2222', '25789', 
		'서울시 종로구', '코아빌딩', 'SQL', '독서','member.jpg')		
		

update team set
phone='010-0000-0000', zipcode='55555', address1='서울시 강남구', address2='강남로', 
skill='Spring', hobby='운동' where no = 1


delete from team where no = 1




select no, name, phone, skill, filename, r
from(
	select no, name, phone, skill, filename, rownum r
		from(
		select no, name, phone, skill, filename 
		from team 
		where name like '%김길동%'
		order by no desc
	)
)where r>=1 and r<=5

select count(*) from TEAM
where name like '%김길동%'



SELECT * FROM team

update team set filename = 'member.jpg' where no = 3



















