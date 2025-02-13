# Gerekli kütüphaneleri yükleyelim
install.packages("tidyverse")  # Veri işleme ve görselleştirme
install.packages("dplyr")      # Veri manipülasyonu
install.packages("ggplot2")    # Görselleştirme
install.packages("summarytools") # Özet istatistikler
install.packages("corrplot")   # Korelasyon grafiği için

# Yüklediğimiz kütüphaneleri çağırıyoruz
library(tidyverse)
library(dplyr)
library(ggplot2)
library(summarytools)
library(corrplot)

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
