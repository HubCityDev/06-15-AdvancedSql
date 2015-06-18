select * from dbo.ufnGetContactInformation(5)

--nope!!!
select * from Person.Person p
inner join dbo.ufnGetContactInformation(p.BusinessEntityID) contactInfo
where BusinessEntityID = 5

--nope!!!
select p.*,contactInfo.* from Person.Person p
INNER JOIN (select * from  Person.BusinessEntityContact c WHERE c.BusinessEntityID = p.BusinessEntityID) contactInfo ON contactInfo.PersonID = p.BusinessEntityID 
where p.BusinessEntityID between 5 and 50

select p.*,contactInfo.* from Person.Person p
INNER JOIN (select * from  Person.BusinessEntityContact c WHERE c.ContactTypeID = 1) contactInfo ON contactInfo.PersonID = p.BusinessEntityID 
where p.BusinessEntityID between 5 and 50

select p.*,contactInfo.* from Person.Person p 
outer apply(select * from dbo.ufnGetContactInformation(p.BusinessEntityID)) contactInfo
where p.BusinessEntityID between 5 and 50

