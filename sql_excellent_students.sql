
---
Оптимальный запрос, который дает информацию о количестве очень усердных студентов.
Под усердным студентом понимается студент, который правильно решил 20 задач за текущий месяц.
  
---

SELECT count(*) as diligent_stud  \
  FROM (SELECT st_id,  \
               correct,  \
               count(*) as cnt  \
          FROM peas  \
         WHERE correct is True  \
         GROUP BY st_id, correct  \
        HAVING count(*) >= 20  \
         ORDER BY cnt) as foo  }
