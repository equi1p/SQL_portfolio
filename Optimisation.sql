Образовательная платформа предлагает пройти студентам курсы по модели trial: 
студент может решить бесплатно лишь 30 горошин в день. Для неограниченного количества заданий 
в определенной дисциплине студенту необходимо приобрести полный доступ. Команда провела эксперимент, 
где был протестирован новый экран оплаты.
  
В одном запросе выгружена следующая информацию о группах пользователей:
  
1. ARPU
2. ARPAU
3. CR в покупку
4. СR активного пользователя в покупку
5. CR пользователя из активности по математике (subject = ’math’) в покупку курса по математике ARPU 
   считается относительно всех пользователей, попавших в группы.

Активным считается пользователь, за все время решивший больше 10 задач правильно в любых дисциплинах.
Активным по математике считается пользователь, за все время решивший 2 или больше задач правильно по математике.

  WITH active_users AS (SELECT foo.st_id
                         FROM (SELECT st_id,
                                      count(*) as cnt
                                 FROM peas
                                WHERE correct is True
                                GROUP BY st_id
                               HAVING COUNT(*) > 10 
                                ORDER BY cnt) as foo),

     math_active_users AS (SELECT math.st_id 
                             FROM (SELECT st_id,
                                          COUNT(*) as cnt
                                     FROM peas
                                    WHERE subject = 'Math' AND correct IS TRUE
                                    GROUP BY st_id
                                   HAVING COUNT(*) >= 2) as math),

     math_payers AS (SELECT st_id
                       FROM final_project_check
                      WHERE subject = 'Math')

SELECT s.test_grp,
       SUM(f.money)/COUNT(DISTINCT s.st_id) as ARPU, -- ARPU
       SUM(f.money)/COUNT(DISTINCT a_u.st_id) as ARPAU, --  ARPAU
       (COUNT(DISTINCT f.st_id)::float / COUNT(DISTINCT s.st_id)::float) * 100 as CR_pay, 
       (COUNT(DISTINCT f.st_id)::float / COUNT(DISTINCT a_u.st_id)::float) * 100 as CR_active_pay,
       (COUNT(DISTINCT m_p.st_id)::float / COUNT(DISTINCT m_a_u.st_id)::float) * 100 as CR_math
  FROM studs as s
  LEFT JOIN final_project_check as f
    ON s.st_id = f.st_id
  LEFT JOIN active_users as a_u
    ON s.st_id = a_u.st_id
  LEFT JOIN math_active_users as m_a_u
    ON s.st_id = m_a_u.st_id
  LEFT JOIN math_payers as m_p
    ON s.st_id = m_p.st_id
 GROUP BY s.test_grp
