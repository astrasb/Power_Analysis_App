ComputeSampleSize <-function (dat,input,...){
## ---- Unpaired_T ----
        if (input$test_type == "Unpaired T-test"){
                if (ncol(dat) > 2){return(NULL)}
                if (nrow(dat) < 2){return(NULL)}
                dat_melt <- melt(dat, 
                                 variable.name = 'condition',
                                 value.name = 'result',
                                 na.rm = TRUE)
                
                ES <- cohen.d(d = dat_melt$result, f = dat_melt$condition)
                
                Sample_size <- wp.t(d = ES$estimate, 
                                    alpha = as.numeric(input$alpha),
                                    power = as.numeric(input$power),
                                    type = "two.sample")%>% 
                        unclass() %>% 
                        as_tibble
                #Sample_size$note <- paste("Note:", Sample_size$note)
                return(Sample_size)
## ---- end_of_chunk ----
## ---- Paired_T ----        
        } else if (input$test_type == "Paired T-test"){ 
                if (ncol(dat) > 2){return(NULL)}
                if (nrow(dat) < 2){return(NULL)}
                dat_complete <- dat[complete.cases(dat),]
                n <- nrow(dat_complete)
                dat_complete$id <- (1:n)
        
                dat_melt <- reshape2::melt(dat_complete,
                                 measure.vars = 1:2,
                                 variable.name = 'condition',
                                 value.name = 'result',
                                 na.rm = TRUE)
                
               
                ES <- cohen.d(d = dat_melt$result, 
                              f = dat_melt$condition, 
                              subject = dat_melt$id, 
                              paired = TRUE)
                
                
                Sample_size <- wp.t(d = ES$estimate,
                                    alpha = as.numeric(input$alpha),
                                    power = as.numeric(input$power),
                                    type = "paired") %>% 
                        unclass() %>% 
                        as_tibble
                #Sample_size$note <- paste("Note:", Sample_size$note)
                return(Sample_size)
           
## ---- end_of_chunk ----
## ---- Chi ----  
                     
        } else if (input$test_type == "Chi-squared"){
                if (ncol(dat) > 2){return(NULL)}
                if (nrow(dat) > 2){return(NULL)}
                dat_melt <- melt(dat,
                                 variable.name = 'condition',
                                 value.name = 'proportion')
                ES <- (2 * asin(sqrt(dat_melt$proportion[[1]]))) - 
                        (2 * asin(sqrt(dat_melt$proportion[[2]])))
                Sample_size <- wp.prop(h = ES, 
                                       alpha = 0.01, ##as.numeric(input$alpha),
                                       power = 0.9, ##as.numeric(input$power),
                                       type = "2p") %>% 
                        unclass() %>% 
                        as_tibble
               # Sample_size$note <- paste("Note:", Sample_size$note)
                Sample_size <- Sample_size %>%
                        select("n", "h", everything())
                return(Sample_size)
                
## ---- end_of_chunk ----
## ---- Onew_ANOVA ----  
                
        } else if (input$test_type == "One-way ANOVA"){
                if (ncol(dat) < 3){return(NULL)}
                k = ncol(dat) # Number of groups

                dat_melt <- melt(dat,
                                  variable.name = 'condition',
                                  value.name = 'result',
                                  na.rm = TRUE
                )
                
                anova1 <- aov(formula = dat_melt$result ~ dat_melt$condition)
                summary(anova1)
                etasquared <- EtaSq(anova1)
                CohensF <- sqrt(etasquared[2]/(1-etasquared[2]))
                Sample_size <- wp.anova(k = k,
                                        f = CohensF,
                                        alpha = as.numeric(input$alpha),
                                        power = as.numeric(input$power)) %>% 
                        unclass() %>% 
                        as_tibble

                Sample_size$n <- Sample_size$n/Sample_size$k
                Sample_size$note <- c("n is the sample size *in each group*")
                Sample_size$method <- c("One-way ANOVA")
                Sample_size <- Sample_size %>%
                        dplyr::select("n", "f", everything())
                return(Sample_size)
      
## ---- end_of_chunk ----
## ---- Twow_ANOVA ----  
                
        } else if (input$test_type == "Two-way ANOVA"){
                if (ncol(dat) <4){return(NULL)}
                k <- ncol(dat) # Total number of groups
                r_num <- 2 ## Number of factors located in rows, 
                ## for a 2 way anova this is hard-wired
                c_num <- k/r_num ## Number of factors located in columns
                
                ## Next couple of lines thanks of K. Zalocusky, PhD
                id_list <- c(1:r_num)
                id_list2 <- c(1:c_num)
                
                ids <- expand.grid(id_list, id_list2)
                ids <- ids[rep(seq_len(nrow(ids)), each = nrow(dat)), ]
                
                dat_melt <- melt(dat)
                dat_melt <- cbind(dat_melt, ids)
                dat_melt <- dat_melt[!is.na(dat_melt$value),] ## Get rid of NA values
                
                dat_melt$Var1 <- as_factor(dat_melt$Var1)
                dat_melt$Var2 <- as_factor(dat_melt$Var2)
                
                anova2 <- aov(formula = dat_melt$value ~ dat_melt$Var1 * dat_melt$Var2)
                etasquared <- EtaSq(anova2)
                CohensF <- sqrt(etasquared[,2]/(1-etasquared[,2]))
                ndf <- summary.aov(anova2) %>% 
                        flatten_df() %>% 
                        dplyr::select(Df) %>% 
                        pull()
                
                Sample_size_Interaction <- wp.kanova(f = CohensF[
                        "dat_melt$Var1:dat_melt$Var2"], 
                                                     ndf = ndf[3],
                                                     alpha = as.numeric(input$alpha),
                                                     power = as.numeric(input$power),
                                                     ng = 4) %>% 
                        unclass() %>% 
                        as_tibble %>% 
                        add_column(name = 'Interaction Effect', .before = "n")
                
                Sample_size_Var1 <- wp.kanova(f = CohensF["dat_melt$Var1"],
                                              ndf = ndf[1],
                                              alpha = as.numeric(input$alpha),
                                              power = as.numeric(input$power),
                                              ng = 4) %>% 
                        unclass() %>%
                        as_tibble %>% 
                        add_column(name = 'Main Effect of Rows', .before = "n")
                
                Sample_size_Var2 <- wp.kanova(f = CohensF["dat_melt$Var2"],
                                              ndf = ndf[2],
                                              alpha = as.numeric(input$alpha),
                                              power = as.numeric(input$power),
                                              ng = 4) %>% 
                        unclass() %>% 
                        as_tibble() %>% 
                        add_column(name = 'Main Effect of Cols', .before = "n")
                
                Sample_size <- full_join(x = Sample_size_Var1,y = Sample_size_Var2) %>% 
                        full_join(y = Sample_size_Interaction) 

                
                Sample_size$n <- Sample_size$n/Sample_size$ng
                Sample_size$note <- c("n is the sample size *in each group*")
                Sample_size$method <- c("Two-way ANOVA")
                Sample_size <- Sample_size %>%
                        dplyr::select("name", "n", "f", everything())
                return(Sample_size)
        }
## ---- end_of_chunk ----
        
}