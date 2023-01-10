### 6.3 ggplot2 패키지
## 6.3.2 ggplot2 기본 구조
# 가장 기본구조는 ggplot() 함수와 geom_로 시작하는 geom 함수
  # ggplot() 함수
    # 좌표 시스템(빈 그래프)를 생성하며, 그 후 레이어를 추가
    # 그래프는 하나 이상의 레이어를 추가해서 완성됨
    # 첫번째 매개변수는 데이터셋으로, 데이터 프레임이어야 함. (매트릭스는 불가능, tibble은 데이터프레임의 변형이므로 가능)
    # '+' 기호를 이용해 레이어를 추가
    # 너무 길어져서 줄바꿈을 해야 할 경우, 반드시 '+'를 입력하고 줄바꿈을 해야 함.
  # geom 함수
    # ggplot object에 다양한 유형의 레이어를 추가함
    # 범주형 데이터 시각화 : geom_bar()
    # 연속형 데이터 시각화 : geom_histogram(), geom_boxplot(), geom_point(), geom_line()
# 문법
  # ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

## 6.3.3 막대 그래프
library(tidyverse)
library(ggplot2)

# [예제1] 막대그래프 1
# 그래프의 순서를 바꾸기 위해서는 factor의 level을 바꿔야 함
diamonds
ggplot(diamonds, aes(x = cut)) + geom_bar()
# 카테고리별로 색을 다르게 하고 싶은 경우, aes 함수의 fill 매개변수로 해당 카테고리를 입력
ggplot(diamonds, aes(x = cut, fill = cut)) + geom_bar()
# cut 및 clarity에 따른 막대 그래프
ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar()                 # 누적 막대 그래프
ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position="fill")  # 100% 누적 막대 그래프
ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position="dodge") # 누적치를 가로로 보여줌
ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position="identity", alpha = 0.2)

cut_count <- diamonds %>%
  group_by(cut) %>%
  count()

ggplot(cut_count, aes(x = cut, y = n)) +
  geom_bar(stat = "identity")

# [예제2]
library(forcats)
gss_cat %>% 
  group_by(race) %>%
  count()

gss_cat %>% 
  mutate(race = fct_infreq(race)) %>%           # 각 수준의 빈도에 대해 내림차순 재정렬
  ggplot(aes(race, fill = race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) +            # 값이 없는 팩터의 수준(labels)을 표시
  scale_fill_manual(values = c("#d1495b", "#edae49", "#66a182", "#2389da")) +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 10),  # 범례 제거
        legend.position = "none") +
  labs(x = "", y = "frequency")               # x, y축의 라벨 변경


# [예제3]
library(lubridate)
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

library(dplyr)
library(nycflights13)
flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(dep_time = make_datetime_100(year, month, day, dep_time),
         arr_time = make_datetime_100(year, month, day, arr_time),
         sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
         sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

## 출발 요일에 대한 분포
library(RColorBrewer)
flights_dt %>% 
  mutate(wday = wday(dep_time, label = TRUE)) %>% 
  ggplot(aes(x = wday, fill = wday)) +
  geom_bar() +
  scale_fill_manual(values = brewer.pal(7, "Spectral"))


## 6.3.4 히스토그램
# 연속형 데이터를 일정 구간으로 ㄴ눈 후, 각 구간별 빈도를 막대로 나타낸 그래프

#[예제]
library(MASS)
ggplot(birthwt, aes(x = bwt)) +
  geom_histogram(fill = "darkgreen") +
  labs(title="Histogram of birthweigth", x = "Birthweight(in gram)", y ="") +
  theme_classic()


labels <- c("1" = "Smoker", "0" = "Nonsmoker")
ggplot(birthwt, aes(x = bwt, fill = smoke)) +
  geom_histogram(binwidth = 200) +
  labs(title="Histogram of birthweigth", x = "Birthweight(in gram)", y ="") +
  facet_grid(smoke ~ ., labeller = labeller(smoke = labels)) +             # 화면 분할
  theme(plot.title = element_text(hjust = 0.5),                            # 제목 가운데 정렬
        legend.position = "none")                                          # 범례 제거


## 6.3.5 상자 그림(box plot)
# 다섯숫자 요약값(five number summary)에 근거하여 나타낸 그래프
  # 사분위수(quantile) : 데이터를 크기 순으로 정렬했을 때, 이를 사등분 하는 값
    # 최솟값
    # 1사분위수(Q1) : 관측값의 25% 순서에 있는 값
    # 중앙값(median) : 관측값의 50% 순서에 있는 값
    # 3사분위수(Q3) : 관측값의 75% 순서에 있는 값
    # 최댓값
    # 사분위수범위(IQR) = Q3-Q1
# 정상범위(Q1 - 1.5*IQR, Q3 + 1.5*IQR)를 벗어난 경우를 이상치(outlier)로 판단
# 그룹별 연속형 데이터의 분포를 비교하는데 용이함

ggplot(birthwt, aes(x = factor(race), y = bwt)) +
  geom_boxplot() +
  coord_flip()


bp <- birthwt %>% 
  mutate(smoke = fct_recode(as_factor(smoke), "Smoker" = "1", "Nonsmoker" = "0"),
         ui = fct_recode(as_factor(ui), "Presence" = "1", "None" = "0")) %>% 
  ggplot(aes(x = factor(race), y = bwt)) +
  geom_boxplot() +
  facet_grid(ui ~ smoke)


bp + geom_point(color = "red", alpha = 0.5)
bp + geom_jitter(color = "red", alpha = 0.5)  # 관측값을 상자 그림 위에 겹쳐서 나타냄


## 6.3.6 산점도
# 두 연속형 변수의 관측 순서쌍을 이차원 평면 상에 점(point)으로 나타낸 그래프
# 한 변수의 변화에 따른 다른 변수의 변화(trend)를 파악하는데 용이
# pch - 점(point) 유형
  # 0~14 : 채우기 없음, 테두리 색상만 color로 설정
  # 15~20 : 채우기 색상만 color로 설정, 테두리 없음
  # 21~24 : 채우기 색상은 fill, 테두리 색상은 color로 설정

# [예제1]
ggplot(birthwt, aes(x = age, y = bwt)) +
  geom_point(size = 3, color = "red", alpha = 0.5, pch = 17) +
  geom_rug(position = "jitter", size = 0.2) +         # lug plot 추가
  geom_smooth(method = lm) +                          # 선형 추세선 추가
  theme_classic()


ggplot(birthwt, aes(x = age, y = bwt)) +
  geom_point(aes(color = lwt), size = 4, alpha = 0.7, pch = 19) +
  scale_color_gradient(low = "#FFF59D", high = "#388E3C") +
  labs(color = "mother's weight") +
  theme_classic()


ggplot(birthwt, aes(x = age, y = bwt,
                    color = factor(smoke), size = lwt)) +
  geom_point(alpha = 0.5) +
  labs(color = "Smoking", size = "Mother's weight") +
  scale_color_discrete(labels = c("No", "Yes"))


## 6.3.7 선 그래프
# 한 변수의 변화에 따른 다른 변수의 변화를 선으로 연결하여 나타낸 그래프
# 일반적으로 x축에는 시간 변수가 종종 사용됨

# [예제1]
# 시간에 따른 이름에 "x"가 포함되는 아기의 비율 변화
library(tidyverse)
library(babynames)
babynames %>% 
  group_by(year) %>% 
  summarise(prop_x = mean(str_detect(name, "x"))) %>% 
  ggplot(aes(year, prop_x)) + 
  geom_line()
