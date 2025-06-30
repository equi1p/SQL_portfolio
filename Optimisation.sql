{\rtf1\ansi\ansicpg1251\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0\c87059;\cssrgb\c100000\c100000\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
SELECT count(*) as diligent_stud  \
  FROM (SELECT st_id,  \
               correct,  \
               count(*) as cnt  \
          FROM peas  \
         WHERE correct is True  \
         GROUP BY st_id, correct  \
        HAVING count(*) >= 20  \
         ORDER BY cnt) as foo  }