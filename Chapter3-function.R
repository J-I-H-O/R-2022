### 3.3 사용자 정의 함수

# 함수명 <- function(매개변수 목록) {
#   실행할 명령문
#   return (결과값)
# }

# 두개의 값 중 큰 수를 리턴하는 함수
mymax <- function(x, y) {
  max.value <- x
  if(y>x) {
    max.value <- y
  }
  
  return(max.value)
}

mymax(10, 20)


# 사용자 정의 함수에서도 매개변수의 초기값을 설정할 수 있음
mydiv <- function(x, y=2) {
  result <- x/y
  return(result)
}

mydiv(10, 3)
mydiv(10)


# 여러개의 값을 반환해야 하는 경우에는 리스트로 묶어 반환
myfunc <- function(x, y) {
  sum.value <- x + y
  mul.value <- x * y
  return(list(sum = sum.value, mul = mul.value))
}

result <- myfunc(5, 8)
print(result)
print(result$sum)
print(result$mul)


# [실습] 
# R에서 제공하는 기본 데이터로 women이라는 데이터가 존재
# 키 / 몸무게 / BMI / 비만도(group)으로 저장하기

# 키와 몸무게를 (인치/파운드) 에서 (cm/kg)으로 변경
mydata <- data.frame(height = women$height * 0.0254,
                     weight = women$weight * 0.453592)

# 1) 키, 몸무게를 입력받아 BMI, 비만도를 반환하는 함수 작성
calBMI <- function(height, weight) {
  BMI <- weight / (height^2)
  if(BMI < 18.5) {
    group <- "저체중"
  } else if(BMI < 23.0) {
    group <- "정상체중"
  } else if(BMI < 25.0) {
    group <- "과체중"
  } else if(BMI < 30.0) {
    group <- "경도비만"
  } else if(BMI < 35.0) {
    group <- "중증도비만"
  } else {
    group <- "고도비만"
  } 
  
  return(list(BMI = BMI, group = group))
}

# 2) mydata에 대해 BMI, 비만도(group) column 추가
res <- c()
for(i in 1:nrow(mydata)) {
  res <- calBMI(mydata$height[i], mydata$weight[i])
  # BMI[i] <- res$BMI
  # group[i] <- res$group
  
  # 데이터프레임에 해당 열이 존재하지 않더라도 이렇게 넣어줄 수 있음
  mydata$BMI[i] <- res$BMI
  mydata$group[i] <- res$group
}

print(mydata)


