### 3.1 조건문
## if-else문
# if-else문 작성시 else는 반드시 if문의 코드블록이 끝나는 }와 같은 줄에 작성해야 함

# [실습] 시험 점수가 80점 이상이면 Pass, 아니라면 Fail
score <- 85

if(score >= 80) {
  result <- "Pass"
} else {
  result <- "Fail"
}

print(result)

# 조건에 따라 두 값 중 하나를 선택하는 경우, ifelse() 함수 사용 가능
# ifelse(비교조건, 조건이 참일 때 선택할 값, 조건이 거짓일 때 선택할 값)
score <- 85
result <- ifelse(score >= 80, "Pass", "Fail")
print(result)

# 다중 if-else문
# else if 문법 사용
score <- 85 

if(score >= 90) {
  grade <- 'A'
} else if(score >= 80) {
  grade <- 'B'
} else { 
  grade <- 'C'
}

print(grade)

# 3.1.3 조건문과 논리연산자
# &(and)와 |(or) 사용
# [실습] 고혈압 분류
# 수축기 혈압과 이완기 혈압에 따른 고혈압 분류 중, 더 안좋은 것을 출력해야 함.
sbp <- 125         # 수축기 혈압
dbp <- 93          # 이완기 혈압

if(sbp >= 160 | dbp >= 100) {
  bp.type <- "2단계 고혈압"
} else if ((140 <= sbp & sbp <= 159) | (90 <= dbp & dbp <= 99)) {
  bp.type <- "1단계 고혈압"
} else if ((120 <= sbp & sbp <= 139) | (80 <= dbp & dbp <= 89)) {
  bp.type <- "고혈압 전단계"
} else if (sbp <= 120 & dbp < 80) {
  bp.type <- "정상 혈압"
}

print(bp.type)