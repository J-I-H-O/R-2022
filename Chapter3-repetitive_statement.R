### 3.2 반복문(repetitive statement)

## 3.2.1 for문
# 범위를 지정하여 반복 수행

# for(반복변수 in 반복범위) {
#   반복할 명령문
# }

# [예제] '*'을 5번 출력
for(i in 1:5) {
  print("*")
}

# [예제] 구구단 2단 출력
# cat() 함수 : 한줄에 여러 개의 값을 결합하여 출력
for(i in 1:9) {
  cat("2 * ", i, " = ", i*2, "\n")
}

# [예제] 1~20 사이의 숫자 중 짝수만 출력
for(i in 1:20) {
  # i가 짝수인 경우
  if(i %% 2 == 0) {
    print(i)
  }
}

# [예제] 1~100 사이의 숫자의 합계 출력
sum <- 0

for(i in 1:100) {
  sum <- sum + i
}

print(sum)

# [실습] iris 데이터셋에 대하여 꽃잎의 길이(Petal.Length)가 
# 1.6 이하이면 Low, 5.1 이상이면 High, 나머지는 Middle로 분류
myiris <- data.frame(iris)
len <- length(myiris$Petal.Length)
Type <- c()

for(i in 1:len) {
  if(myiris$Petal.Length[i] <= 1.6) {
    Type[i] <- "Low"
  } else if (myiris$Petal.Length[i] >= 5.1) {
    Type[i] <- "High"
  } else {
    Type[i] <- "Middle"
  }
  # cat(i, myiris$Petal.Length[i], Type[i], "\n")
}

myiris <- cbind(myiris, Type)
print(myiris)

## 3.2.2 while문
# 어떤 조건을 만족하는 동안 코드블록 수행, 해당 조건이 거짓인 경우 반복문 종료

# while(비교조건) {
#   반복할 명령문
# }

# [예제] 1~100 사이의 숫자의 합계 출력
sum <- 0
i <- 1

while(i <= 100) {
  sum <- sum + i
  i <- i+1
}

print(sum)


## 3.2.3 break와 next
# break : 반복문을 중단시킴
# next : 반복문의 시작 지점으로 되돌림

# [예제] 1~5 사이의 값의 합계 출력
sum <- 0

for(i in 1:10) {
  if(i > 5) break
  sum <- sum + i
}

print(sum)

# [예제] 1~10 사이의 숫자 중 홀수의 합계 출력
sum <- 0

for(i in 1:10) {
  # i가 짝수인 경우 next
  if(i %% 2 == 0) next
  sum <- sum + i
}

print(sum)
