### 4.1 tidyverse 이해

# 패키지 설치 : 파일창에서 packages 탭 선택, install 버튼 클릭
              # 어떤 패키지를 가져올지 입력하면 됨
              # 또는 콘솔에 install.packages(패키지명 또는 문자열 벡터) 입력
              # install.packages("tibble")
              # install.packages(c("tibble", "readr"))

install.packages("tidyverse")

# library() 함수를 이용해 설치한 패키지를 import
library(tidyverse)

# R에 기본 정의된 함수 filter(), lag()와 dplyr에 정의된 filter(), lag()가 충돌
# dplyr의 함수들이 기본 함수들을 덮어쓰게 되고, 기존 함수들을 사용하기 위해서는 fullname을 사용해야 함.
# e.g) stats::filter()

# ── Conflicts ────────────────────────────────────── tidyverse_conflicts()
# ✖ dplyr::filter() masks stats::filter()
# ✖ dplyr::lag()    masks stats::lag()


### 4.4 파이프 연산자 : %>%
# 다중 연산을 하나의 순차적인 연산의 결합으로 표현하는 도구
# 데이터 연산의 흐름을 좌에서 우로 변경 (기존 방식은 안에서 밖으로)
# 왼쪽 표현식(left-hand side expression)의 결과를 오른쪽 표현식(right-hand side expresstion)으로 전달
# 이때 lhs는 rhs의 첫번째 매개변수로 사용됨
# lhs가 사용될 위치를 지정하기 위해서는 rhs에서 place-holder '.'를 사용해야 함
# 연산 작업 중 어느 위치에서나 쉽계 단계를 추가할 수 있고, 가독성을 향상시킴
# magrittr 패키지에 포함됨, magrittr 패키지는 tidyverse 패키지에 포함되어있으므로 tidyverse만 import 하면 됨.
# R 4.1.0 version에서 기본 파이프 연산자 |> 가 추가됨.

# 기존의 방식. 안쪽 -> 바깥쪽
# h(g(f(x)))
nrow(subset(iris, Species == "setosa"))

# 파이프 연산자 적용
# x %>% f() %>% g() %>% h()
iris %>% 
  subset(Species == "setosa") %>%
  nrow()
# R 4.1.0의 기본 파이프 연산자 |> 사용
iris |>
  subset(Species == "setosa") |>
  nrow()

# place-holder '.'을 이용해 rhs에서 lhs가 사용될 위치를 지정
# 미지정 시 lhs는 rhs의 첫번째 인자로 사용됨
"World" %>% cat("Hello", .)


### 4.5 tibble 패키지
# tibble : tidyverse에서 사용하는 R 데이터 객체
# 좀 더 편리하게 사용할 수 있도록 수정된 특수한 종류의 데이터프레임
  # 데이터 출력 시 콘솔창을 넘어가지 않도록 설계
    # 각 열의 유형을 열 이름과 함께 표시
    # 처음 10개의 행과 한 화면에 들어갈 수 있는 열만 표시. 더 보려면 콘솔창 늘려야함
    # 전체 데이터셋을 보기 위해서는 View() 함수 사용
# tidyverse의 다른 패키지들에서 데이터 객체로 tibble을 사용해야 함
# 입력 유형(input type)이 변하지 않음
# 변수 이름을 수정할 수 없으며, 행 이름과 산술연산을 지원하지 않음

# 2013년 뉴욕에서 출발한 항공편의 dataset을 tibble로 저장한 것
install.packages("nycflights13")
library(nycflights13)
flights
flights %>% View()

# tibble 생성
# tibble() 함수 사용
# 길이가 1인 입력은 자동으로 재사용함
# ``(backticks)를 사용하여 변수명을 더 유연하게 지정할 수 있음. 기본 R에서의 명명규칙을 따르지 않아도 됨.
library(tibble)      # tidyverse에 포함
mytb1 <- tibble(
  x = 1:5,
  y = 1,             # 길이가 1인 입력은 자동으로 재사용함
  z = x^2 + y,
  `^ ___ ^` = TRUE     # ``(backticks)를 사용하여 변수명을 더 유연하게 지정할 수 있음
)

print(mytb1)

# tibble <-> dataframe 간 전환 가능
# as_tibble() : dataframe -> tibble 변환
# as.data.frame() : tibble -> dataframe 변환
as_tibble(iris)
as.data.frame(flights)

# tibble 객체는 부분집합을 만드는데 엄격함
# 하나의 열만 추출하려면 [[]] 또는 $ 사용

# 데이터프레임에서 여러 행과 열을 뽑아내면 그 결과는 데이터프레임
# 그러나, 하나의 열이나 행만 뽑아내면 그 결과는 벡터
df <- data.frame(x=1:3, y=3:1, z=4:6)
df
# object() 함수 : 객체의 타입을 알려주는 함수
df[, 1:2] %>% class()     # data.frame
df[, 1] %>% class()       # inteager형 벡터
df[, 1] %>% is()          
df[, 1] %>% is.vector()   # TRUE
df[, 1] %>% is.data.frame()

# tibble 객체를 index로 추출하더라도 벡터가 아닌, tibble 객체가 리턴됨
tb1 <- tibble(x=1:3, y=3:1, z=4:6)
tb1
tb1[, 1:2] %>% class()   # tibble 객체
tb1[, 1] %>% class()     # tibble 객체
tb1[, 1] %>% is()        # tibble 객체
tb1[, 1] %>% is.vector() # FALSE

# tibble 객체의 열을 벡터로 추출하고 싶은 경우, [[]] 또는 $ 사용
tb1[[1]] %>% class()     # inteager형 벡터 
tb1$x %>% class()        # inteager형 벡터


### 4.6 readr 패키지
# 외부 파일을 tibble 객체로 불러오거나 저장하는 함수를 제공하는 패키지
# R에서 기본으로 제공하는 read.csv()함수는 외부 파일을 데이터프레임으로 불러옴

## 4.6.2 read_csv() 함수
# 외부 파일을 tibble 객체로 불러오는 함수
# read.csv()보다 빠르고, 호환성과 재현성이 뛰어남
library(readr)
setwd("C:/R-2022")
data <- read_csv("./dataSet/StudentSurvey.csv")
data
