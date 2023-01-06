### 5.3 stringr 패키지
# 문자열을 다루는 함수 제공
# 모든 함수가 "str_"로 시작하여 일관성있게 설계됨
library(tidyverse)
library(stringr)

## 5.3.2.1 str_length() 함수
# 문자열에서 문자의 개수(길이) 확인, 공백도 카운트 됨
# [예제 1]
str1 <- c("a", "R for data science", NA)
str1 %>% str_length()

# [예제 2]
install.packages("babynames")
library(babynames)

# dplyr::count() 함수 - 그룹별 빈도 값 산출
#        매개변수 wt - 기본값은 NULL로 각 그룹의 행 개수 계산,
#                      변수를 입력하면 각 그룹에 대한 합계 계산
babynames
babynames %>%
  count(length = str_length(name), wt = n)  # 이름 길이의 분포

babynames %>%
  filter(str_length(name) == 15) %>%        # 이름이 15글자인 아기들 filter
  count(name, wt = n, sort = TRUE)          # 이름이 15글자인 아기들 분포


## 5.3.2.2 str_sub() 함수
# 문자열에서 특정 위치의 문자 추출
# 매개변수 start, end도 포함되기 때문에 반환되는 문자열의 길이는 end-start+1
# [예제 1]
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)                            # 문자열의 1번째 문자부터 3번째 문자까지 추출
str_sub(x, -3, -1)                          # 문자열의 끝에서 3번째 문자부터 마지막 문자까지 추출
str_sub("a", 1, 5)                          # 문자열이 너무 짧더라도 에러 발생하지 않음

# [예제 2]
babynames %>%
  mutate(first = str_sub(name, 1, 1),       # 이름의 첫번째 문자 추출 후 babynames tibble 객체에 붙임
         last = str_sub(name, -1, -1))      # 이름의 마지막 문자 추출 후 babynames tibble 객체에 붙임


## 5.3.2.3 str_to_lower(), str_to_upper() 함수
# 대소문자 변환
str_to_lower(c("Apple", "Banana", "Pear"))
str_to_upper(c("Apple", "Banana", "Pear"))


### 5.3.3 데이터에서 문자열 생성
## 5.3.3.1 str_c() 함수
# 두 개 이상의 벡터에 대해 원소별로 결합하여 단일 문자형 벡터로 만듬

letters
str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ")                    # 매개변수 sep : 입력된 벡터들을 결합할 때 사용하는 문자
str_c(letters, " is for", "...")                        # 여러개의 벡터도 결합 가능
str_c(letters[-26], " comes before ", letters[-1])
str_c(letters, collapse = "")                           # 매개변수 collapse : 입력된 벡터를 단일 문자열로 결합할 때 사용하는 문자
str_c(letters, collapse = " ")
str_c(c("a", NA, "b"), "-d")                            # 결측값(NA)이 있는 경우, 결합 결과는 결측값(NA)

# dplyr::mutate()와 함께 사용
info <- tibble(name = c("Kim", "Lee", "Park"))
info
info %>% mutate(greeting = str_c("Hi, ", name, "!"))


## 5.3.3.2 str_glue() 함수
# 고정 문자열과 변수 문자열을 결합할 때 ""를 반복적으로 타이핑하는 것을 방지하여 가독성을 높임
# {}안에 작성된 코드는 문자열 외부에 있는 것처럼 실행
info
info %>% mutate(greeting = str_glue("Hi, {name}!"))


## 5.3.3.3 str_flatten() 함수
# 벡터의 각 요소를 하나의 문자열로 결합
str_flatten(c("x", "y", "z"))
str_flatten(c("x", "y", "z"), collapse = ", ")          # 매개변수 collapse : 입력된 벡터를 단일 문자열로 결합할 때 사용하는 문자
str_flatten(c("x", "y", "z"), collapse = ", ", last = ", and ") # 매개변수 last :마지막 원소를 결합할 때 사용할 문자

mytbl <- tibble(name = c("Carmen", "Carmen", "Marvin", "Terence", "Terence", "Terence"),
                fruit = c("banana", "apple", "nectarine", "cantaloupe", "papaya", "madarine"))
mytbl
mytbl %>%
  group_by(name) %>%
  summarise(fruits = str_flatten(fruit, ", "))


### 5.3.4 정규 표현식을 이용한 패턴 매칭
## 5.3.4.1 정규 표현식(regular expression)
# 주어진 문자열에 특정한 패턴이 있는 경우, 해당 패턴을 일반화(수식화)한 문자열
# 특정 패턴을 표현한 문자열을 메;타 문자라고 함
# 일반적으로 특정 패턴을 가지는 문자열을 찾고, 다른 값으로 대체하기 위해 사용

# . : 무엇이든 한글자
# ^ : ^ 뒤에 오는 표현식으로 시작하는 경우
# $ : $ 앞에 오는 표현식으로 끝나는 경우
# ? : ? 앞에 오는 표현식이 0 또는 1번 일치하는 경우
# + : + 앞에 오는 표현이 1번 또는 그 이상 일치하는 경우
# * : * 앞에 오는 표현이 0번 또는 그 이상 포함하는 경우

x <- c("apple", "banana", "pear")
# matching exact strings
str_view(x, "an")
# matching any character(except a newline)
str_view(x, ".a.")
# matching the start/end of the string
str_view(x, "^a")
str_view(x, "a$")
# only matching a complete string
str_view(c("apple pie", "apple", "apple cake"), "apple")

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")  # <CC> 와 이어진 <CC> 총 2개
str_view(x, "CC+")
str_view(x, "CC*")

# []을 사용하여 문자 집합을 매칭 ([]내의 문자들을 포함한 것을 매칭)
  # [abcd] : "a", "b", "c", "d" 중 하나 이상과 매칭
  # [^abcd] : "a", "b", "c", "d"를 제외한 어느 것과도 매칭
x <- c("apple", "banana", "pear")
str_view(x, "[abcd]")

names <- c("Hadley", "Mine", "Garrett")
str_view_all(names, "[aeiou]")      # 모음 찾기
str_view_all(names, "[^aeiou]")     # 자음 찾기(각각 매칭)
str_view_all(names, "[^aeiou]+")    # 자음 찾기(붙어있는 자음들은 한번에 매칭)

# 정규 표현식에서 특수 동작이 아닌 기호 자체로 사용하기 위해서는 그 앞에 '\' 사용
  # 작은 따옴표 : \'
  # 큰 따옴표 : \"
  # 역슬래시 : \\\\
  # 점 : \\.

str_view(c("a'c"), "\'")
str_view(c("a\"c"), "\"")                    # method 1. 큰 따옴표를 큰따옴표로 감싼 상태로 문자로 사용하려면 백슬래시 사용
str_view(c('a"c'), '\"')                     # method 2. 큰 따옴표를 문자로 사용하려면 작은따옴표로 감싸주면 됨
str_view(c("a\\b"), "\\\\")                  # 역슬래시는 기호로 사용하기 위해 두번 써줘야 함
str_view(c("abc", "a.c", "bef"), "\\.")      # 점(.)은 예외적으로 역슬래시를 두번 넣어 \\. 와 같이 표현
str_view(c("abc", "a.c", "bef"), "a\\.c")

## 5.3.4.2 str_detect() 함수
# 패턴이 일치하면 TRUE 반환
# 정규 표현식 사용 가능

# [예제1] 주어진 문자열들에 알파벳 "e"가 포함되어 있는지 확인
str_detect(c("apple", "banana", "pear"), "e")

# [예제2] R 기본 데이터셋 words 이용
words
sum(str_detect(words, "^t"))                 # t로 시작하는 단어의 수
mean(str_detect(words, "[aeiou]$"))          # 모음으로 끝나는 단어의 비율

# [예제3] babynames 라이브러리에 포함된 데이터셋 사용
# filter 함수와 함께 사용
library(babynames)
babynames 
babynames %>% filter(str_detect(name, "x"))  # 이름에 "x"가 포함되는 아기 이름 filter

babynames %>%
  group_by(year) %>%                               # 연도별로 그룹
  summarise(prop_x = mean(str_detect(name, "X")))  # 이름에 x가 포함되는 아기들의 비율 산출


## 5.3.4.3 str_count() 함수
# str_detect() 함수의 변형으로, 일치하는 패턴의 개수 반환

# [예제1] 각 문자열에서 p의 개수 출력
str_count(c("apple", "banana", "pear"), "p")

# [예제2]
babynames %>%
  count(name) %>%
  mutate(vowels = str_count(name, "[aeiouAEIOU]"),
         consonants = str_count(name, "[^aeiouAEIOU]"))

## 5.3.4.4 str_replace(), str_replace_all() 함수
# 일치하는 패턴을 새 문자열로 변경

# [예제1]
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")                    # 처음으로 일치하는 패턴만 변경
str_replace_all(x, "[aeiou]", "-")                # 일치하는 모든 패턴을 변경

# [예제2] 벡터를 이용하여 다중 대체 가능
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))
