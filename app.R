# =========================================================================
# GEREKLİ KÜTÜPHANELER
# =========================================================================

# install.packages(c("shiny", "shinydashboard", "tidyverse", "dplyr", "ggplot2", "plotly"))

library(shiny)
library(shinydashboard)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

# =========================================================================
# SHINY UYGULAMASI: UI (Kullanıcı Arayüzü) ve SERVER (Sunucu Mantığı)
# =========================================================================

# UI (Kullanıcı Arayüzü) - SHINY DASHBOARD YAPISI
ui <- dashboardPage(
    
    # 1. Başlık Çubuğu (Header)
    dashboardHeader(
        title = "2024 ML/Veri Bilimi Maaş Analizi",
        titleWidth = 300 
    ),
    
    # 2. Yan Menü (Sidebar) - Filtreler Buraya Geliyor
    dashboardSidebar(
        width = 300, 
        
        # Filtre başlığı
        h4(div(style = "padding: 10px; color: white;", "Görselleştirmeyi Filtrele")),
        
        # 1. Deneyim Düzeyi Filtresi (EN, MI, SE, EX)
        uiOutput("deneyim_seviyesi_filtresi"),
        
        # 2. İş Unvanı Filtresi
        uiOutput("unvan_filtresi"),
        
        # 3. Şirket Büyüklüğü Filtresi (S, M, L)
        uiOutput("buyukluk_filtresi"),
        
        # 4. Çalışanın İkamet Ülkesi Filtresi
        uiOutput("ulke_filtresi")
    ),
    
    # 3. Ana Gövde (Body) - Görselleştirmeler Buraya Geliyor
    dashboardBody(
        
        fluidRow(
            # Box kullanarak grafiği daha düzenli bir kutu içine alıyoruz
            box(
                title = "Filtrelenmiş Maaş Dağılımı (Deneyim Seviyesine Göre)", 
                status = "primary", 
                solidHeader = TRUE, 
                width = 12, 
                
                # Plotly ile interaktif grafik çıktısını göster
                plotlyOutput("maas_dagilimi_plot", height = "500px")
            )
        )
    )
)

# SERVER (Sunucu Mantığı)
server <- function(input, output, session) {
    
    # =========================================================================
    # 1. VERİ YÜKLEME VE TEMİZLEME
    # =========================================================================
    
    # Not: 'salaries.csv' dosyasının bu 'app.R' dosyasıyla aynı klasörde olması gerekir.
    data <- read.csv("salaries.csv")
    
    # Eksik verileri tamamen kaldırıyoruz
    data <- na.omit(data)
    
    # =========================================================================
    # 2. DİNAMİK FİLTRE SEÇENEKLERİNİN OLUŞTURULMASI
    # =========================================================================
    
    # Her filtre için dinamik seçenekler oluşturulur
    output$deneyim_seviyesi_filtresi <- renderUI({
        choices <- sort(unique(data$experience_level))
        selectInput("deneyim_filtre", "1. Deneyim Düzeyi:", 
                    choices = choices, selected = choices, multiple = TRUE, selectize = TRUE)
    })
    
    output$unvan_filtresi <- renderUI({
        choices <- sort(unique(data$job_title))
        selectInput("unvan_filtre", "2. İş Unvanı:", 
                    choices = choices, selected = choices, multiple = TRUE, selectize = TRUE)
    })
    
    output$buyukluk_filtresi <- renderUI({
        choices <- sort(unique(data$company_size))
        selectInput("buyukluk_filtre", "3. Şirket Büyüklüğü:", 
                    choices = choices, selected = choices, multiple = TRUE, selectize = TRUE)
    })
    
    output$ulke_filtresi <- renderUI({
        choices <- sort(unique(data$employee_residence))
        selectInput("ulke_filtre", "4. Çalışanın İkamet Ülkesi:", 
                    choices = choices, selected = choices, multiple = TRUE, selectize = TRUE)
    })
    
    # =========================================================================
    # 3. REAKTİF VERİ SETİ (KULLANICI SEÇİMLERİNE GÖRE FİLTRELEME)
    # =========================================================================
    
    # Reaktif veri, kullanıcı arayüzündeki herhangi bir filtre değiştiğinde otomatik olarak güncellenir.
    filtered_data <- reactive({
        
        # Filtrelerin yüklenmesini bekle (Gerekli - req)
        req(input$deneyim_filtre, input$unvan_filtre, input$buyukluk_filtre, input$ulke_filtre)
        
        temp_data <- data %>%
            # Deneyim Düzeyi Filtresi
            filter(experience_level %in% input$deneyim_filtre) %>%
            # İş Unvanı Filtresi
            filter(job_title %in% input$unvan_filtre) %>%
            # Şirket Büyüklüğü Filtresi
            filter(company_size %in% input$buyukluk_filtre) %>%
            # İkamet Ülkesi Filtresi
            filter(employee_residence %in% input$ulke_filtre)
        
        temp_data
    })
    
    # =========================================================================
    # 4. REAKTİF GÖRSELLEŞTİRME (FİLTRELENMİŞ VERİ KULLANILARAK)
    # =========================================================================
    
    # Deneyim Seviyelerine Göre Maaş Dağılımı box plot'ı
    output$maas_dagilimi_plot <- renderPlotly({
        plot_data <- filtered_data()
        
        # Filtre sonucu boş veri seti dönerse kullanıcıya uyarı göster
        if (nrow(plot_data) == 0) {
            return(ggplot() + 
                       annotate("text", x=0, y=0, label="Belirtilen kriterlere uygun veri bulunamadı.", size=6, color="red") + 
                       theme_void())
        }
        
        # ggplot kodu
        p <- ggplot(plot_data, aes(x = experience_level, y = salary_in_usd, fill = experience_level)) +
            geom_boxplot(alpha = 0.8, outlier.colour = "red", outlier.shape = 16) +
            scale_fill_brewer(palette = "Set2") +
            labs(title = "Maaş Dağılımı (Box Plot)",
                 x = "Deneyim Seviyesi",
                 y = "Maaş (USD)") +
            theme_light() +
            # Genel tema iyileştirmesi
            theme(plot.title = element_text(hjust = 0.5, face = "bold"),
                  legend.position = "none") 
        
        # Plotly ile interaktif hale getir
        ggplotly(p, tooltip = c("x", "y"))
    })
    
}

# Uygulamayı Çalıştır
shinyApp(ui, server)

