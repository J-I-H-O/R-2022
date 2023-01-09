### 5.5 lubridate 패키지
# 날짜, 시간을 다루는 함수 제공
# 핵심 tidyverse에 포함되지 않으므로 별도로 불러와야 함
library(tidyverse)
library(lubridate)

## 5.5.2 날짜/시간 생성
# 날짜/시간에 대한 3가지 유형
  # 데이트형(date) : 날짜, tibble에서 <date>로 출력
  # 타임형(time) : 하루 중 시간, tibble에서 <time>으로 출력
  # 데이트-타입형(date-time) : 날짜 및 시간, 시점을 고유하게 식별, tibble에서 <dttm>으로 출력
# 날짜/시간을 생성하는 3가지 방법
  # 문자열로부터 생성
  # 개별 데이트-타임형 구성요소로부터 생성
  # 기존의 날짜/시간 객체로부터 생성

today()           # 오늘 날짜 출력
class(today())    # Date 형
now()             # 현재 데이트-타임 출력

# 문자열로부터 생성
  # 연, 월, 일의 순서를 확인한 후 "y", "m", "d"를 같은 순서로 배치
  # 데이트-타임형을 생성하려면 _와 "h", "m", "s" 중 하나 이상을 추가
ymd("2017-01-31")
mdy("January 31th, 2017")
dmy("31-Jan-2017")
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

# 개별 데이트-타임형 구성요소로부터 생성
  # 데이트-타임형의 개별 구성요소들이 여러 열에 걸쳐있는 경우
  # 데이트형은 make_date() 함수, 데이트-타임ㅎ형은 make_datetime() 함수 사용
library(nycflights13)
flights
flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(departure = make_datetime(year, month, day, hour, minute))

# year, month, day, time을 입력받아 데이트-타임형 객체를 생성
make_datetime_100 <- function(year, month, day, time) {
  # 현재 flights의 시간들은 숫자형으로 시간,분이 이어져있음 (e.g.) 7시 20분 : 720
  # %/%는 정수 나누기 연산자. 결과로 정수 몫만 결과로 나타냄
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>%     # 결측값이 아닌 것만 추출
  mutate(dep_time = make_datetime_100(year, month, day, dep_time),
         arr_time = make_datetime_100(year, month, day, arr_time),
         sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
         sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt

# 기존의 날짜/시간 객체로부터 생성
  # as_datetime(), as_date() 함수 : 데이트-타임형과 데이트형 간의 상호 전환
today()
as_datetime(today())
now()
as_date(now())


### 5.5.3 날짜/시간 구성요소
library(tidyverse)
library(lubridate)
# 개별 구성요소 가져오기 : year(), month(), week(), day(), hour(), minute(), second() 함수
# 해당 연을 기준으로 몇 번째 일(day)힌지 반환 - yday()
# 해당 월을 기준으로 몇 번째 일인지 반환 - mday()
# 해당 주에서 무슨 요일인지 반환 - wday90
  # 1은 일요일, 7은 토요일을 의미
# month(), wday() 함수 관련 매개변수
  # 매개변수 label : TURE 이면 문자열, FALSE이면 숫자로 표시
  # 매개변수 abbr : FALSE이면 이름 전체 반환(label이 FALSE이면 무시)
datetime <- ymd_hms("2016-07-08 12:34:56")

year(datetime)
month(datetime)
month(datetime, label = TRUE) # Levels 존재. factor.
day(datetime)
hour(datetime)
minute(datetime)
second(datetime)

yday(datetime)
mday(datetime)
wday(datetime)
wday(datetime, label = TRUE, abbr = FALSE)


### 5.5.4 시간 범위 object
## 5.5.4.1 시간 범위 object 유형
# duration object : 정확한 초를 나타냄
# period object : 주와 월과 같이 사람의 단위로 표현함
# interval object : 시작 시점과 종료 시점을 나타냄

## 5.5.4.2 duration object
# date object에 뺄셈을 적용하면 difftime object가 생성되며, 상황에 따라 초, 분, 시, 일 또는 주 단위로 시간 범위를 기록하므로 
  # 작업할 때마다 단위가 변경됨.
# 이를 보완하기 위한 duration object는 항상 초 단위를 사용하여 시간 범위를 나타냄(단위 통일)
  # as.duration() 함수로 생성
# duration object는 덧셈, 뺄셈, 곱셈을 적용할 수 있음
  # 윤년, 일광 절약 시간제 등의 규칙에 영향을 받기 때문에 시간, 월, 연과 같은 큰 시간 단위로 측정한 값에 대해 연선 결과가 실제와 항상 일치하지 않음.

# duration object 생성
dday <- today() - ymd(19990113) # difftime object. 일관성x
class(dday)
dday
as.duration(dday) # 초단위로 기간을 기록

# (5.4.3)의 개별 구성요소 생성 함수 이름의 앞에 d, 뒤에 s를 붙이는 형태로도 duration object 생성 가능
dseconds(15)
dminutes(10)
dhours(c(12, 24))
ddays(0:5)
dweeks(3)
dmonths(1:6)
dyears(1)

# duration object에 산술연산 적용 가능
2 * dyears(1)
dyears(1) + dweeks(12) + dhours(15)

tomorrow <- today() + ddays(1)
last_year <- today() - dyears(1)
tomorrow
last_year

# daylight saving time
one_pm <- ymd_hms("2016-03-12 13:00:00", tz = "America/New_York")
one_pm                                        # "2016-03-12 13:00:00 EST"
one_pm + ddays(1)                             # "2016-03-13 14:00:00 EDT"


## 5.5.4.3 period object
# 지정된 단위로 period object
# 사람이 인식하는 단위로, 작동 방식이 보다 직관적

# period object 생성
# (5.4.3)의 개별 구성요소 생성 함수 이름의 뒤에 s를 붙이는 형태로도 duration object 생성 가능
seconds(15)
minutes(10)
hours(c(12, 24))
days(0:5)
weeks(3)
months(1:6)
years(1)

# period object에 산술 연산 적용
10 * (months(6) + days(1))
days(50) + hours(25) + minutes(2)

# 윤년
ymd("2016-01-01") + dyears(1)
ymd("2016-01-01") + years(1)

# daylight saving time
one_pm <- ymd_hms("2016-03-12 13:00:00", tz = "America/New_York")
one_pm                                        # "2016-03-12 13:00:00 EST"
one_pm + days(1)                             # "2016-03-13 13:00:00 EDT"

# 심야 항공편의 도착시간에 days(1)을 더해줌
flights_dt %>% 
  filter(arr_time < dep_time)

flights_dt <- flights_dt %>% 
  mutate(overnight = arr_time < dep_time,
         arr_time = arr_time + days(overnight * 1),
         sched_arr_time = sched_arr_time + days(overnight * 1))

flights_dt %>% 
  filter(overnight, arr_time < dep_time)

## 5.5.4.4 interval object
# interval object는 시작 시점과 종료 시점을 나타내므로, 정확한 시간 범위를 확인할 수 있음
# interval object 생성 : interval()함수, %--% dustkswk
# 정수 나눗셈을 이용하여 interval object의 기간을 확인할 수 있음
## interval object 생성
next_year <- today() + years(1)
interval(start = today(), end = next_year)    # today() %--% next_year

# interval object 기간 확인
(today() %--% next_year) / ddays(1)
