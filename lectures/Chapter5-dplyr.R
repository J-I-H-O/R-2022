### Chapter 5 데이터 전처리

## 5.1 dplyr 패키지
# 탐색적 자료분석, 데이터 가공에 매우 유용하고 편리한 함수 제공
# dplyr 함수는 적용 대상에 따라 아래와 같이 정리 가능

# 행 : 
  # filter(), arrange()
# 열 :
  # select(), rename(), mutate(), relocate()
# 그룹 :
  # summarise(), group_by()
# 테이블

library(tidyverse)
library(nycflights13)
flights %>% glimpse()


## 5.1.2 행 관련 함수

# filter() 함수 : 조건에 맞는 행 추출
  # %in% 연산자 : 왼쪽의 값이 오른쪽에 있는 값들 중 어느 하나와 같으면 TRUE
# filter(flights, arr_delay >= 120)
flights %>% filter(arr_delay >= 120)          # 120분 이상 연착한 항공편
flights %>% filter(month == 1 & day == 1)     # 1월 1일에 출발한 항공편
flights %>% filter(month %in% c(3,5,8))       # 3, 5, 8월에 출발한 항공편

# arrange() 함수 : 특정 변수를 기준으로 행 정렬, 기본값은 오름차순
  # 정렬 기준 변수가 여러 개인 경우 순차적으로 적용
  # desc() 함수 : 내림차순 정렬
flights %>% arrange(year, month, day, dep_time)  # year, month, day, dep_time 기준으로 행 정렬
flights %>% arrange(desc(dep_delay))             # 출발 지연 시간을 기준으로 내림차순 정렬
flights %>%
  filter(dep_delay <= 10 & dep_delay >= -10) %>% # 정시 10분 전후로 출발한 항공편 중에서
  arrange(desc(arr_delay))                       # 도착 지연 시간을 기준으로 내림차순 정렬


## 5.1.3 열 관련 함수

# select() 함수 : 특정 변수 추출
  # 추출한 변수 명을 바꿀 수 있음
  # 도우미(helpers) 함수
    # starts_with() : 특정 문자열로 시작하는 이름 매칭
    # ends_with() : 특정 문자열로 끝나는 이름 매칭
    # contains() : 특정 문자열을 포함하는 이름 매칭
    # num_range("x", 1:3) : x1, x2, x3 매칭
flights %>% select(year, month, day)      # 출발 연월일 column 추출
flights %>% select(year:day)              # 출발 연월일 column 추출
flights %>% select(-(year:day))           # 출발 연월일 column을 제외하고 출력
flights %>% select(dep_time = dep_time, arr_time = arr_time)  # 변수명 변경하여 추출
flights %>% select(starts_with("sched"))  # "sched"로 시작하는 column 추출
flights %>% select(ends_with("time"))     # "time" 으로 끝나는 column 추출
flights %>% select(contains("arr"))       # "arr"를 포함하는 column 추출

# rename() 함수 : 특정 column명 변경(select로도 가능)
# 명시적으로 언급하지 않은 모든 변수를 유지함
flights %>% select(dep_time = dep_time, arr_time = arr_time)  # 변수명 변경하여 추출
flights %>% rename(dep_time = dep_time, arr_time = arr_time)  # 변수명 변경하여 전체 출력

# mutate() 함수 : 데이터셋에 존재하는 변수(column)로부터 새로운 변수 생성
# 새로운 변수는 항상 데이터셋 마지막 열에 추가됨
  # 매개변수 .before : 새로운 변수를 특정 위치의 앞에 추가
  # 매개변수 .after : 새로운 변수를 특정 위치의 뒤에 추가
flights %>% mutate(gain = dep_delay - arr_delay)
flights %>% mutate(speed = distance / air_time * 60, .before = 1)
flights %>% mutate(hour = air_time / 60, .after = air_time)

# relocate() 함수 : 변수 위치 변경, 기본값은 첫번째 열
# mutate()와 같이 매개변수 .before와 .after를 이용하여 위치 지정
flights
flights %>% relocate(air_time, distance)                    # air_time과 distance를 맨 앞쪽 열로 이동
flights %>% relocate(carrier:tailnum, .before = day)        # carrier ~ tailnum을 day변수 앞으로 이동


## 5.1.4 그룹 관련 함수
# summarie() 함수 : 통계량(평균, 최솟값, 최댓값 등)을 계산하여 하나의 행으로 요약
# 여러개의 다양한 요약 함수 사용 가능
# 매개변수 na.rm : 결측값(NA)이 존재할 때, 결측값을 제외하고 통계값 계산
# n() 함수 : 그룹별 크기 계산
flights %>% summarise(mean = mean(air_time, na.rm = TRUE),           # 평균
                      std_dev = sd(air_time, na.rm = TRUE),          # 표준편차
                      min = min(air_time, na.rm = TRUE),             # 최솟값
                      max = max(air_time, na.rm = TRUE),             # 최댓값
                      n = n())                                       # 값의 개수

# 매개변수로 na.rm 을 설정하지 않으면 결측값이 제외되지 않으므로 결과로 NA가 반환됨
flights %>% summarise(mean = mean(air_time),           # 평균
                      std_dev = sd(air_time),          # 표준편차
                      min = min(air_time),             # 최솟값
                      max = max(air_time),             # 최댓값
                      n = n())                         # 값의 개수   

# group_by() 함수 : 특정 변수를 기준으로 그룹화
# 그룹별 통계량을 계산할 때 주로 사용
# 일반적으로 summarise()와 함께 사용
# 여러 변수를 기준으로 그룹화 가능
  # summarize() 함수에서 매개변수 .groups
    # "drop" : 모든 그룹의 수준을 푼다
    # "keep" : 같은 그룹화 구조가 유지된다
    # "drop_last" : 메세지를 없앤다
# ungroup() 함수 : 그룹화 제거
flights %>% group_by(month)           # group_by()만 적용하면 월별로 그룹을 나누었다는 사실만 알 수 있고, 별다른 변화는 없음

# 월별로 그룹을 나누고, 각 그룹의 평균 출발 지연시간과 그룹 크기를 계산
flights %>% group_by(month) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE), n = n())

flights %>% group_by(year, month, day) %>% summarise(n = n())
flights %>% group_by(month) %>% ungroup() %>% summarise(n = n())     # 그룹화 제거
