### 5.4 forcats 패키지
# 팩터(factor)를 다루는 함수 제공
library(tidyverse)
library(stringr)

gss_cat %>%
  count(marital)

## 5.4.2 팩터 레벨 순서 변경
# fct_inorder() : 팩터가 만들어질 때 팩터가 순차적으로 입력된 순서에 따라서 정렬
# fct_reorder() : 기준값을 줘서 순서를 바꿈
# fct_relevel() : 기존에 있는 레벨에 이름을 지정해줘서 레벨의 순서를 변경
f <- factor(c("b", "b", "a", "c", "c", "c"))
f                # Levels: a b c
fct_inorder(f)   # Levels: b a c


# 그래프를 그릴 때 팩터 순서로 
relig_summary <- gss_cat %>%
                  group_by(relig) %>%
                  summarise(age = mean(age, na.rm = TRUE),
                            tvhours = mean(tvhours, na.rm = TRUE),
                            n = n()) %>%
                  mutate(relig = fct_reorder(relig, tvhours)) # fct_reorder()로 relig와 tvhours 기준으로 팩터 순서 바꿈

library(ggplot2)
ggplot(relig_summary, aes(tvhours, relig)) + 
  geom_point(size = 5) +
  theme(axis.text = element_text(size = 20))

gss_cat %%
  mutate(rincome = fct_relevel(rincome, "Not applicable")) %>%
  count(rincome)


## 5.4.3 팩터 레벨 변경
# fct_recode() 함수 : 팩터 레벨의 이름 변경에 사용
  # 명시적으로 언급되지 않은 레벨은 그대로 둠
  # 그룹으로 결합하려면 이전 레벨들을 새로운 레벨로 할당
  # 서로 같지 않은 범주들을 함께 묶는다면 잘못된 결과 도출 (데이터 분석 관점)
# fct_collapse() 함수 : 다수의 레벨 병합
  # 각각의 새로운 변수에 대해 이전 레벨로 이루어진 벡터를 제공
# fct_lump() 함수 : 소규모 그룹 모두를 묶음
  # 매개변수 n : Other를 제외한 그룹 개수 지정

# [예제1] fct_recode()
# partyid의 레벨 이름 변경
# 언급되지 않은 레벨은 그대로 둠
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat")) %>%
  count(partyid)

# 새로운 레벨 이름을 동일하게 부여함으로써 묶어줄 수 있음
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party")) %>%
  count(partyid)


# [예제2] fct_collapse()
# 다수의 레벨 병합하여 새로운 레벨 생성
# recode와 다른 점 : 변수 명을 따옴표로 묶지 않아도 됨
gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat"))) %>%
  count(partyid)


# [예제3] fct_lump()
# 소규모 그룹을 모두 묶어줌
# 매개변수 n : Other를 제외한 그룹 개수 지정. 즉, 상위 n개를 제외한 나머지를 모두 Other로 묶어줌

# 빈도가 가장 큰 것과 나머지로 나뉨
gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

gss_cat %>%
  mutate(relig = fct_lump(relig, n = 5)) %>%    # 상위 n개를 제외한 나머지를 모두 Other로 묶어줌
  count(relig, sort = TRUE) %>%                 # 레벨 순서를 빈도에 따라 정렬
  print(n = Inf)
