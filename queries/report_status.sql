select
	status,
	count(*) as total,
	YEAR(GETDATE()) - YEAR(MAX(birth_date)) as youngest,
	YEAR(GETDATE()) - YEAR(MIN(birth_date)) as oldest
from person
group by status