# Gerekli kütüphaneleri yükleyelim
install.packages("tidyverse")  # Veri işleme ve görselleştirme
install.packages("dplyr")      # Veri manipülasyonu
install.packages("ggplot2")    # Görselleştirme
install.packages("summarytools") # Özet istatistikler
install.packages("corrplot")   # Korelasyon grafiği için
install.packages("randomForest")
install.packages("plotly")

# Yüklediğimiz kütüphaneleri çağırıyoruz
library(tidyverse)
library(dplyr)
library(ggplot2)
library(summarytools)
library(corrplot)
library(randomForest)
library(plotly)
library(RColorBrewer)

# Veri setini yükleyelim
data <- read.csv("salaries.csv") 

# Veri setine genel bakış
head(data)  # İlk birkaç satırı görmek

# Veri setinin yapısı
str(data)

# Özet istatistikler
summary(data)

# Verideki boş değerleri kontrol etme
sum(is.na(data))  # Boş değerlerin sayısı

# Eksik değerleri kontrol etme ve temizleme
data <- na.omit(data)  # Eksik verileri tamamen kaldırıyoruz

# Deneyim seviyelerine göre maaş ortalamalarını hesaplama
salary_by_experience <- data %>%
  group_by(experience_level) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE))

print(salary_by_experience)

# Şirket büyüklüğüne göre maaş ortalamalarını hesaplama
salary_by_company_size <- data %>%
  group_by(company_size) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE))

print(salary_by_company_size)

# Ülkelere göre maaş ortalamaları
salary_by_country <- data %>%
  group_by(employee_residence) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE)) %>%
  arrange(desc(mean_salary))

print(salary_by_country)

# Uzaktan çalışma oranı ile maaş arasındaki ilişkiyi görselleştirme
ggplot(data, aes(x = remote_ratio, y = salary_in_usd, color = experience_level)) +
  geom_point(alpha = 0.7, size = 3) +
  scale_color_viridis_d() +
  labs(title = "Maaş ve Uzaktan Çalışma Oranı İlişkisi",
       x = "Uzaktan Çalışma Oranı", 
       y = "Maaş (USD)",
       color = "Deneyim Seviyesi") +
  theme_minimal()

# company_size'ı sayısal bir forma dönüştürme
data$company_size_numeric <- case_when(
  data$company_size == "S" ~ 1,
  data$company_size == "M" ~ 2,
  data$company_size == "L" ~ 3,
  TRUE ~ NA_real_
)

# Sayısal değişkenlerin korelasyonunu hesaplama
cor_data <- data %>%
  select(salary_in_usd, remote_ratio, company_size_numeric) %>%
  cor(use = "complete.obs")

# Korelasyon grafiği çizme
corrplot(cor_data, method = "color",
         col = colorRampPalette(c("blue", "white", "red"))(200), 
         addCoef.col = "black", tl.col = "black", tl.srt = 45)

# Doğrusal regresyon modeli kurma
model <- lm(salary_in_usd ~ experience_level + remote_ratio, data = data)

# Modelin özetini gösterme
summary(model)

# Deneyim seviyelerine göre maaş dağılımı
ggplot(data, aes(x = experience_level, y = salary_in_usd, fill = experience_level)) +
  geom_boxplot(alpha = 0.8, outlier.colour = "red", outlier.shape = 16) +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Deneyim Seviyelerine Göre Maaş Dağılımı",
       x = "Deneyim Seviyesi", 
       y = "Maaş (USD)") +
  theme_light()


# Ülkelere göre maaş farkları

ggplot(salary_by_country, aes(x = reorder(employee_residence, mean_salary), y = mean_salary, fill = mean_salary)) +
  geom_bar(stat = "identity") +
  scale_fill_distiller(palette = "YlGnBu", direction = 1) +  # Sarıdan maviye geçiş
  coord_flip() +
  labs(title = "Ülkelere Göre Maaş Farkları",
       x = "Ülke", y = "Ortalama Maaş (USD)") +
  theme_minimal()


set.seed(123)
rf_model <- randomForest(salary_in_usd ~ experience_level + remote_ratio + company_size, data = data, ntree = 500, importance = TRUE)

# Modelin önem derecelerini görselleştirme
varImpPlot(rf_model, main = "Değişkenlerin Maaş Üzerindeki Etkisi")



salary_by_job <- data %>%
  group_by(job_title) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE)) %>%
  arrange(desc(mean_salary))

ggplot(salary_by_job, aes(x = reorder(job_title, mean_salary), y = mean_salary, fill = mean_salary)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis_c(option = "magma") +
  coord_flip() +
  labs(title = "Pozisyonlara Göre Ortalama Maaşlar",
       x = "Pozisyon", y = "Ortalama Maaş (USD)") +
  theme_minimal()


# Yıllara göre ortalama maaşı hesapla
avg_salary_by_year <- data %>%
  group_by(year = as.factor(work_year)) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE))

# Geliştirilmiş çizgi grafik
ggplot(avg_salary_by_year, aes(x = year, y = mean_salary, group = 1)) +
  geom_line(color = "#0073C2FF", size = 1.5) +  # Mavi tonlu çizgi
  geom_point(color = "#EFC000FF", size = 4) +   # Sarı tonlu noktalar
  geom_text(aes(label = round(mean_salary, 0)), vjust = -1, size = 3.5) +  # Noktalara etiket
  labs(title = "Yıllara Göre Ortalama Maaş Değişimi",
       x = "Yıl", y = "Ortalama Maaş (USD)") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(data, aes(x = experience_level, y = salary_in_usd, fill = company_size)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "Deneyim ve Şirket Büyüklüğüne Göre Maaş Dağılımı",
       x = "Deneyim Seviyesi", y = "Maaş (USD)", fill = "Şirket Büyüklüğü") +
  theme_minimal() +
  facet_wrap(~company_size)

salary_by_country_size <- data %>%
  group_by(employee_residence, company_size) %>%
  summarise(mean_salary = mean(salary_in_usd, na.rm = TRUE)) %>%
  arrange(desc(mean_salary))

ggplot(salary_by_country_size, aes(x = reorder(employee_residence, mean_salary), y = mean_salary, fill = company_size)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_viridis_d() +
  coord_flip() +
  labs(title = "Ülke ve Şirket Büyüklüğüne Göre Maaş Farkları",
       x = "Ülke", y = "Ortalama Maaş (USD)", fill = "Şirket Büyüklüğü") +
  theme_minimal()


p <- ggplot(data, aes(x = remote_ratio, y = salary_in_usd, color = experience_level)) +
  geom_point(alpha = 0.7, size = 3) +
  scale_color_viridis_d() +
  labs(title = "Maaş ve Uzaktan Çalışma Oranı İlişkisi",
       x = "Uzaktan Çalışma Oranı", 
       y = "Maaş (USD)",
       color = "Deneyim Seviyesi") +
  theme_minimal()

ggplotly(p)  
