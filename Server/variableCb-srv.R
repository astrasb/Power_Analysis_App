# Variable Codebook
# Explanations of Reported Variables
output$variables <- renderUI({
        result<-dataOutput()
        if (!is.null(result)){
                method <- dplyr::pull(result,method)
                str0 <- c('n = sample size')
                str2 <- c('alpha = significance level (aka false positive rate)')
                str3 <- c('power = statistical power (aka 1 - false negative rate)')
                
                if (grepl('t-test', method[1])){
                        str1<- c('d = effect size (Cohens D)')
                        str4<- c('alternative = direction of the alternative hypothesis')
                        str5<- c(' ')
                        str6<- c(' ')
                        
                } else if (grepl('proportion', method[1])){
                        str1<- c('h = effect size')
                        str4<- c(' ')
                        str5<- c(' ')
                        str6<- c(' ')
                        
                } else if (grepl('One-way', method[1])){
                        str1<- c('f = effect size (f-ratio)')
                        str4<- c('k = number of groups')
                        str5<- c(' ')
                        str6<- c(' ')
                        
                } else if (grepl('Two-way', method[1])){
                        str1<- c('f = effect size (f-ratio)')
                        str4<- c('ndf = numerator degrees of freedom')
                        str5<- c('ddf = denominator degrees of freedom')
                        str6<- c('ng = number of groups')
                }
                vals$v <-data.frame(variables = c(str0,str1,str2,str3,str4,str5,str6))
                apply(vals$v, 1, function(x) tags$p(x['variables']))
        }})