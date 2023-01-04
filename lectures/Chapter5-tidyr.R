### 5.2 tidyr 패키지
# 타이디 데이터를 만드는데 도움을 주는 함수 제공

## 5.2.2 wide format과 long format
# wide format
  # 사람이 읽기 좋은 포맷, 통계학에서 다루는 데이터 테이블 구조와 돌일한 개념
  # 하나의 관측 단위가 한 행을 이루고, 관측 단위에 대한 측정값이 열(변수)로 표현된 데이터 형태
  # pivot_wider() [권장], spread(), dcast() [reshape2 패키지]
# long format
  # 컴퓨터가 이해하기 편한 구조
  # 하나로 묶을 수 있는 여러 변수들이 가로줄에 배치된 형태의 데이터
  # wide format보다 유연하여 데이터 추가 및 삭제 용이
  # picot_longer() [권장], gather(), melt() [reshape2 패키지]

# 관측 대상을 여러개의 열의 반복으로 나타냈다면 wide form, 여러개의 행의 반복으로 나타냈다면 long form

# [예제] WHO에서 발표한 1999~2000년 3개 국가(아프가니스탄, 브라질, 중국)의 결핵 사례 수
library(tidyverse)
library(tidyr)
# 여러개의 행에 하나의 관측 대상 -> long form
table1  # long format
table2  # long format
table3  # long format

# 하나의 행에 하나의 관측 대상 -> wide form
table4a # 반복이 열(변수) 이름으로 들어가면 wide format
table4b # long format

# wide format -> long format =====================================
# pivot_longer() 함수 사용
table4a %>%
  pivot_longer(cols = c(`1999`, `2000`),          # 열 선택  
               names_to = "year",                 # 이름 지어주기
               values_to = "cases") %>%           # 이름 지어주기
  mutate(year = parse_integer(year))
  
table4b %>%
  pivot_longer(cols = -country,
               names_to = "year",
               values_to = "population") %>%
  mutate(year = parse_integer(year))

# [예제2] wide format -> long format
relig_income # wide format
relig_income %>%
  pivot_longer(cols = -religion,
               names_to = "income",
               values_to = "count") %>%
  view()

# [예제3]
billboard
# pivot할 열을 지정하는 방법은 dplyr::select() 스타일 표기법 따름. starts_with를 이용해 'wk'로 시작하는 열들을 선택
billboard %>% # wide format
  pivot_longer(cols = starts_with("wk"),    
               names_to = "week",
               names_prefix = "wk",               # week 열의 값에서 wk를 제거
               values_to = "rank",
               values_drop_na = TRUE) %>%         # value에서 결측값을 모두 버림
  mutate(week = parse_integer(week))              # week 열의 값들의 타입을 문자형에서 숫자형으로 변경



# long format -> wide format =====================================
table1 %>%
  pivot_wider(names_from = year,                  # column으로 보내려는 행들을 선택해야 함 (변수 이름을 어디서 따올 지)
              values_from = c(cases, population)) %>% 
  relocate(country, ends_with("1999")) 


# table2로부터 table1을 만드는 예제
table2
table1

table2 %>%
  pivot_wider(names_from = type,                  # type만 wide로 만들어주면 됨
              values_from = count)

# 응용해보기
table2 %>%
  pivot_wider(names_from = type,                        # type을 wide로
              values_from = count) %>%
  mutate(rate = cases / population * 100000) %>%        # mutate() 함수로 새로운 열도 추가 가능
  pivot_wider(names_from = year,
              values_from = c(cases, population, rate)) # 한번 더 wide로

# [예제]
fish_encounters
fish_encounters %>%
  pivot_wider(names_from = station,
              values_from = seen,
              values_fill = 0)                    # 결측값 대체

# seprate 함수
# 여러개의 변수가 하나의 열에 저장되어 있을 때, 이를 분리
table3
table3 %>%
  separate(col = rate,
           into = c("cases", "population"))

# unite() 함수
# 여러개의 열을 하나의 열로 결합
table5
table5 %>% unite(col = new_year, century, year) # century와 year를 결합해 new_year 열 생성

# 

## 5.2.3 결측값 처리
# 결측값은 알려지지 않은 값을 표시. 결측값은 파급된다 = 결측값을 이용해 연산 시 결과는 결측값임을 뜻함.
# is.na() 함수 : 결측값 확인
NA > 5
10 == NA
NA + 10
NA / 2
NA == NA

is.na(NA)
