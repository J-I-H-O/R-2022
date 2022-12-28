# 2022-12-26
# Chapter2 데이터 객체 실습 코드

### 2.2 벡터
## 2,2,1 벡터 이해
# vector: 1차원 형태의 데이터를 저장할 수 있는 저장소
# 같은 자료형을 가져야함.
# C()함수를 이용해 벡터 생성
# 숫자와 문자를 동일한 벡터에 저장하면 숫자는 문자로 변경됨
# 데이터 테이블에서 각각의 열을 생성한다고 생각

v1 <- c(1, 2, 3, 4, 5)             # 숫자형 벡터
v2 <- c("a", "b", "C")             # 문자형 벡터
v3 <- c(TRUE, FALSE, FALSE)        # 논리형 벡터
v4 <- c(1, 2, 3, "a", "b", "c")    # 문자형 벡터

print(v1) # [1] 1 2 3 4 5
print(v2) # [1] "a" "b" "C"
print(v3) # [1]  TRUE FALSE FALSE
print(v4) # [1] "1" "2" "3" "a" "b" "c"


# 벡터를 결합해 새로운 벡터 생성 가능
v5 <- c(6, 7, 8, 9, 10)
v6 <- c(v1, v5)

print(v6) # [1]  1  2  3  4  5  6  7  8  9 10


# 연속적인 데이터 생성시 콜론 이용. [1, 15] 범위, 1 간격 씩 증가
v7 <- 1:15

print(v7) #  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15


# seq(from, to, by)
# from ~ to 사이의 by 만큼의 텀을 가진 시퀀스 생성
# 자세한 reference는 help에서 제공
v8 <- seq(1, 10, 2) # v8 <- seq(to=10, by=2, from=1) 과 동일

print(v8) # [1] 1 3 5 7 9


# rep(x, ...)
# 반복된 숫자로 이루어진 벡터 생성
v9 <- rep(1:5, times=3)
v10 <- rep(1:5, each=3)

print(v9)  #  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
print(v10) #  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5


## 2.2.2 인덱스(index)
# 벡터에 저장된 각각의 값들을 구별하기 위해 앞쪽의 값부터 시작하여 부여한 순서값
# R 언어에서 인덱스는 1부터 시작

v <- c(6, 8, 1, 9, 7)
print(v[1]) # [1] 6
print(v[6]) # [1] NA

## 2.2.3 원소값 추출
# 인덱스로 vector에 사용된 모든 함수를 사용할 수 있음

# v의 1, 3, 5번 인덱스의 값 출력
print(v[c(1, 3, 5)])    # [1] 6 1 7

# v의 1:3 번 인덱스의 값들 출력
print(v[1:3])           # [1] 6 8 1

# v의 2~5 번 인덱스의 값을 2씩 건너뛰며 출력
print(v[seq(2, 5, 2)])  # [1] 8 9

# v의 1번 인덱스의 값을 10번 반복하여 출력
print(v[rep(1, 10)])    # [1] 6 6 6 6 6 6 6 6 6 6

# v의 1, 3, 4번 인덱스의 값을 각각 10번씩 출력
print(v[rep(c(1, 3, 4), each=10)]) #  [1] 6 6 6 6 6 6 6 6 6 6 1 1 1 1 1 1 1 1 1 1 9 9 9 9 9 9 9 9 9 9

# v의 5번 인덱스를 제외한 나머지 값 출력
print(v[-5])            # [1] 6 8 1 9

# v의 2, 4번 인덱스를 제외한 나머지 값 출력
print(v[-c(2, 4)])      # [1] 6 1 7


## 2.2.4 벡터의 산술연산
# 벡터에 대한 산술연산은 벡터의 모든 값들에 대한 연산으로 바뀌어 실행
# 벡터와 벡터 간 연산은 대응되는 위치에 있는 값끼리의 연산으로 바뀌어 실행됨
# 벡터 간 연산 중 벡터의 길이가 서로 다른 경우 짧은 벡터를 처음부터 반복시켜 억지로 늘린 뒤 계산
v11 <- c(3, 7, 6)
v12 <- c(4, 2, 8)
v13 <- 1:5
print(v11 + 2)   # [1] 5 9 8
print(v11 - v12) # [1] -1  5 -2

# 벡터의 길이가 서로 다르므로 길이가 짧은 v11을 처음부터 반복시켜 억지로 늘린 뒤 계산함
# v11 : 3 7 6 (3 7)
# v13 : 1 2 3  4 5
# res : 4 9 9  7 12
print(v11 + v13) # [1]  4  9  9  7 12


## 벡터에 적용 가능한 함수
# sum : 합계
print(sum(1:100))        # [1] 5050
# mean : 평균
print(mean(1:100))       # [1] 50.5
# median : 전체 값의 중간값
print(median(1:100))     # [1] 50.5
# max : 최댓값
print(max(1:100))        # [1] 100
# min : 최솟값
print(min(1:100))        # [1] 1
# var : 분산(variance)
print(var(1:100))        # [1] 841.6667
# sd : 표준편차(standard deviation) 분산에 루트를 씌운 것 == sqrt(var())
print(sd(1:100))         # [1] 29.01149
print(sqrt(var(1:100)))  # [1] 29.01149
# length : 벡터에 포함된 값들의 개수
print(length(1:100))     # [1] 100


## 2.2.5 논리연산자
# 등호와 부등호는 (>, <, >=, <=, ==, !=)로 동일함
# and는 &, or는 | 하나로 표현됨
# 논리연산도 벡터에 포함된 각각의 값에 대한 연산으로 바뀌어 실행됨

# 각 원소가 5보다 크거나 같으면 TRUE, 아니면 FALSE 출력
v14 <- 1:10
print(v14 >= 5)           # [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

# table() 함수를 통해 FALSE와 TRUE의 개수를 테이블 형태로 출력 가능
table(v14 >= 5)

# 인덱스 안에 논리연산자가 포함되면 TRUE에 해당하는 값들만 반환함
print(v14[v14 >= 5])      # [1]  5  6  7  8  9 10

# 논리값이 산술연산에 사용되면 TRUE는 1로, FALSE는 0으로 간주됨
# TRUE의 개수를 합한 값이 출력. 결과적으로 조건을 만족하는 값의 개수를 출력.
print(sum(v14 >= 5))      # [1] 6

# v14에서 5보다 크거나 같은 값들의 합계 출력
print(sum(v14[v14 >= 5])) # [1] 45


## 2.2.6 리스트
# 서로 다른 자료형의 값들을 1차원 배열에 저장하고 다룰 수 있도록 함
# list() 함수를 이용하여 리스트 생성
# 리스트에 저장된 값은 [[]]를 사용하거나, 리스트이름$값의이름 의 형태로 추출 가능
myinfo <-list(name="kim", age=25, smoking="FALSE", score=c(90,95,100))
print(myinfo[[1]])
print(myinfo$score)


## 2.2.7 팩터(factor)
# 문자형 데이터가 저장된 벡터의 한 종류
# 문자형 벡터를 만든 뒤 factor() 함수를 이용하여 팩터를 생성
fav_season <- c("spring", "fall", "winter", "summer", "summer", "spring")
table(fav_season)
fac_fav_season <- factor(fav_season)
table(fac_fav_season)

# 벡터를 이용해 팩터를 생성할 때 파라미터로 levels를 지정하면 순서를 지정할 수 있음
fac2_fav_season <- factor(fav_season, levels=c("spring", "summer", "fall", "winter"))
table(fac2_fav_season)
barplot(table(fac2_fav_season)) # barplot() 함수를 이용해 막대 그래프로 시각적으로 표현 가능

# levels() 함수는 팩터에 저장된 값들의 종류를 알려줌
print(levels(fac2_fav_season))

# 팩터는 사전에 정의된 값 외에 다른 값들은 입력하지 못하도록 함
fac2_fav_season[7] = "summer"
print(fac2_fav_season)
fac2_fav_season[8] = "abc"     # Warning message:
                               # In `[<-.factor`(`*tmp*`, 8, value = "abc") :
                               #   요인의 수준(factor level)이 올바르지 않아 NA가 생성되었습니다.

print(fac2_fav_season)         # [1] spring fall   winter summer summer spring summer <NA>  


### 2.3 행렬(matrix)과 데이터프레임(data frame)
# 1차원 데이터: 단일 주제의 데이터 <- 벡터
# 2차원 데이터: 여러 주제의 데이터(여러개의 열을 가짐) <- 매트릭스, 데이터프레임

## 2.3.1 행렬 이해
# 2차원 테이블 형태의 자료구조
# 모든 셀에 저장되는 값은 동일한 자료형이어야 함
# matrix() 함수를 이용하여 행렬 생성
  # 매개변수 nrow, ncol : 행렬의 행과 열의 개수 지정
  # 매개변수 byrow : TRUE인 경우 행렬에 저장될 값들을 행 방향으로 채움. 기본값은 FALSE, 열 방향으로 채워짐

m1 <- matrix(1:20, nrow=4, ncol=5)  # 1:20와 nrow만 인자로 넘겨도 매트릭스는 생성됨. 1:20과 ncol만 넘겨도 마찬가지
m2 <- matrix(1:20, nrow=4, ncol=5, byrow=TRUE)
print(m1)
print(m2)

# 2개의 인덱스 값으로 행렬의 원소 추출 가능
# [행, 열]과 같이 사용
# 행 또는 열을 지정하지 않는 경우 입력한 열 또는 행 전체를 추출
print(m1[2, 4]) # 2행 4열의 값 출력
print(m1[3, ])  # 3행 전체 출력
print(m1[, 5])  # 5열 전체 출력
print(m1[,])    # 모든 행, 열을 출력(매트릭스 전체 출력)

# rbind(), cbind() 함수를 이용해 벡터 또는 행렬 결합 가능
# rbind() : row 방향으로 붙임 (아래에 결합)
# cbind() : column 방향으로 붙임 (오른쪽에 결합)
m3 <- rbind(m1, m2)
m4 <- cbind(m1, m2)
m5 <- cbind(m1, c(1:4))
print(m3)
print(m4)
print(m5)

# rownames(), colnames() 함수를 이용해 행과 열에 이름을 지정할 수 있음
score <- matrix(c(80, 67, 74,
                  82, 95, 88,
                  75, 84, 82),
                nrow = 3, ncol = 3, byrow = TRUE)
rownames(score) <- c("Kim", "Lee", "Park")
colnames(score) <- c("Kor", "Eng", "Math")
print(score)
print(rownames(score))
print(colnames(score))


## 2.3.2 데이터프레임 이해
# 서로 다른 형태의 데이터를 2차원 데이터 형태로 묶을 수 있는 자료구조
# 행렬 : 저장되는 모든 값이 동일한 자료형
# 데이터프레임 : 서로 다른 자료형의 값을 함께 저장할 수 있음
# 다만 데이터프레임은 특정 열의 값들은 자료형이 동일해야함. 데이터테이블에서 각 열의 데이터가 동일한 특성을 가짐과 같음
# 여러개의 벡터를 결합하는 형태로, 각각의 열을 생성해 결합함
# data.frame() 함수를 이용해 생성

df1 <- data.frame(name = c("Kim", "Lee", "Park", "Choi"),
                  age = c(24, 25, 22, 27),
                  btype = factor(c("A", "B", "O", "B")),
                  religion = c(TRUE, FALSE, TRUE, TRUE))
print(df1)

# 매트릭스와 동일한 방법으로 데이터 추출 가능
print(df1[1, 2])   # 1행 2열에 위치한 값 출력
print(df1[, 3])    # 3열의 모든 값 출력
print(df1[, 1:2])  # 여러개의 행 또는 열 추출 가능
print(df1[, c(2, 4)])    # 여러개의 행 또는 열 추출 가능
print(df1[, "religion"]) # 인덱스에서 열의 이름으로도 접근 가능

# 데이터프레임에서는 열의 이름을 통해 열 데이터를 추출할 수 있음
# `(데이터프레임 이름)$(열 이름)`
print(df1$btype)

# cbind()와 rbind()를 이용해 벡터 또는 데이터프레임과 결합 가능
df2 <- cbind(df1, c("dog", "cat", "bird", "dog"))
colnames(df2)[5] <- "pet"  # 새로 추가된 5번째 열에 "pet" 이라는 이름 지정. 
                           # 지정하지 않을 시 열의 이름으로 벡터 자체가 들어감
print(df2)


## 2.3.3 행렬과 데이터프레임 다루기
print(iris)                     # iris는 기본으로 제공되는 data set
print(dim(iris))                # dim() : 행과 열의 개수 출력
print(nrow(iris))               # nrow() : 행의 개수 출력
print(ncol(iris))               # ncol() : 열의 개수 출력
print(colnames(iris))           # colnames() : 열 이름 출력, names()와 결과 동일
print(head(iris))               # head() : 데이터셋의 앞부분 일부 출력
print(head(iris, n=10))         # parameter로 n을 주어 미리보기 개수 지정 가능
print(tail(iris))               # tail() : 데이터셋의 뒷부분 일부 출력
print(str(iris))                # str() : 데이터셋의 요약 정보 출력

print(iris[, 5])                # iris[, "Species"] 와 동일한 결과 출력 <- 열의 이름으로 접근 가능
print(unique(iris[, 5]))        # unique() : 어떤 결과에서 중복을 제거하여 데이터 보여줌
print(table(iris[, "Species"])) # table()을 통해 빈도 체크

print(colSums(iris[, -5]))      # 각 열별 합계 출력
print(colMeans(iris[, -5]))     # 각 열별 평균 출력
print(rowSums(iris[, -5]))      # 각 행별 합계 출력
print(rowMeans(iris[, -5]))     # 각 행별 평균 출력


# subset() 함수 이용하여 조건에 맞는 행과 열의 값 추출할 수 있음
  # 매개변수 subset : 행에 대한 조건 지정. 조건이 TRUE인 값들만 추출하여 출력됨
  # 매개변수 select ; 추출하고자하는 열 지정
iris.new1 <- subset(iris, Species == "setosa")
iris.new2 <- subset(iris, subset = Sepal.Length > 5.0 & Sepal.Width > 4.0)
iris.new3 <- subset(iris, select = c("Sepal.Length", "Sepal.Width"))

print(iris.new1)
print(iris.new2)
print(iris.new3)


## 행렬 및 데이터프레임 산술 연산
# 벡터와 마찬가지로 행렬이나 데이터프레임도 각 원소에 대한 연산으로 바뀌어 실행됨
# 행렬간의 연산은 동일한 위치에 있는 값끼리의 연산으로 바뀌어 실행되므로 두 행렬의 크기가 같아야함.
m1 <- matrix(1:20, nrow = 4, ncol = 5)    # 4x5 행렬
m2 <- matrix(21:40, nrow = 4, ncol = 5)   # 4x5 행렬

print(m1 + 2)   # m1의 모든 원소에 2를 더한 매트릭스 출력
print(m2 * 3)   # m2의 모든 원소에 3을 곱한 매트릭스 출력
print(m1 + m2)  # m1과 m2의 모든 원소들을 각각 더한 매트릭스 출력. 두 매트릭스 크기가 같아야함.
print(m1 * m2)  # m1과 m2의 모든 원소들을 각각 곱함. 진정한 의미의 행렬곱(%*%)은 아님.

m3 <- matrix(1:6, nrow = 2, ncol = 3)     # 2x3 행렬
m4 <- matrix(1:12, nrow = 3, ncol = 4)    # 3x4 행렬
print(m3 %*% m4)                          # 실제 행렬곱을 위해 %*% 연산자 사용
                                          # m3의 column 수와 m4의 row 수가 같아야 행렬곱 가능

print(t(m1))    # t() 함수를 사용해 전치행렬 출력 가능


### ★★★★★4 외부 파일 읽기 및 쓰기 ★★★★★
# 시험 때 파일을 읽어와서 처리하는 문제 나올 것

# 2.4.1. 작업 폴더 설정
# setwd() 함수를 이용하여 작업할 폴더의 경로 지정
rootDir = "C:/R-2022"
dataDir = "/dataSet"
dataPath = paste0(rootDir, dataDir)
setwd(dataPath)

# 2.4.2. 외부 파일 읽기
# read.csv() 함수를 이용해 외부에 있는 csv 파일을 불러옴. dataFrame으로 불러와짐
data <- read.csv("StudentSurvey.csv")
head(data)

# 2.4.3. 외부 파일 쓰기
# write.csv() 함수를 이용해 외부로 csv 파일을 저장
smoking <- subset(data, Smoke=="Yes")
write.csv(smoking, "smoking.csv")


