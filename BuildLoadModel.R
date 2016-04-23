library(shiny)


load('freq1.RData')
load('freq2.RData')
load('freq3.RData')


process<- function(x) {
        # Text Transformations to remove odd characters #
        # replace APOSTROPHES OF 2 OR MORE with space - WHY??? that never happens..
        # output=lapply(output,FUN= function(x) gsub("'{2}"rr, " ",x))
        # Replace numbers with spaces... not sure why to do that yet either.
        # output=lapply(output,FUN= function(x) gsub("[0-9]", " ",x))
        #erase # tags
        x=gsub("\\#", "", x)
        # Erase commas.
        x=gsub(",?", "", x)
        # Erase ellipsis
        x=gsub("\\.{3,}", "", x)
        # Erase colon
        x=gsub("\\:", "", x)
        # Merge on contractions (apostrophe):
        x=gsub("\\'", "", x)
        # Erase |:
        x=gsub("\\|", "", x)
        # Erase {}:
        x=gsub("\\{", "", x)
        x=gsub("\\}", "", x)
        # Erase []:
        x=gsub("\\[|\\]","",x)
        ##### SENTENCE SPLITTING AND CLEANUP
        # Split into sentences only on single periods or any amount of question marks or exclamation marks and -
        # ok here is where you change structure fundamentally... 
        # Faster if I unlist once? no i guess it keeps getting relisted.
        x<-strsplit(unlist(x),"[\\.]{1}")
        x<-strsplit(unlist(x),"\\?+")
        x<-strsplit(unlist(x),"\\!+")
        x<-strsplit(unlist(x),"\\-+")
        
        # Split also on parentheses
        x<-strsplit(unlist(x),"\\(+")
        x<-strsplit(unlist(x),"\\)+")
        # split also on quotation marks
        x<-strsplit(unlist(x),"\\\"")
        # remove spaces at start and end of sentences:
        # HERE is where the problem begins. why?
        x<-gsub("^\\s+", "", unlist(x))
        x<-gsub("\\s+$", "", unlist(x))
        # Replace ~ and any whitespace around with just one space
        x<-gsub("\\s*~\\s*", " ", unlist(x))
        # Replace forward slash with space
        x<-gsub("\\/", " ", unlist(x))
        # Replace + signs with space
        x<-gsub("\\+", " ", unlist(x))
        # it s a 
        x<-gsub("it s ", "its ", unlist(x))
        # 'i m not'
        x<-gsub("i m not", "im not", unlist(x))
        # 'i didn t'
        x<-gsub("i didn t", "i didnt", unlist(x))
        # 'i don t'
        x<-gsub("i don t", "i dont", unlist(x))
        # ' i m '
        x<-gsub(" i m ", " im ", unlist(x))
        
        # Eliminate empty and single letter values (more?)
        # x=x[which(nchar(x)!=1)]
        x=x[which(nchar(x)!=0)]
        x = tolower(x)
        #eliminate more than one space
        gsub("\\s+"," ",x)
}

bigramPred <- function(x) {
        test <- tail(strsplit(x, " ")[[1]], 1)
        unigram=paste(test[1])
        Xpred=freq1[grep(pattern = paste0("^",unigram," "),x = names(freq1))]
        Xpred = names(Xpred[1])
        paste(substr(Xpred,nchar(unigram)+ 2,nchar(Xpred)))
}

trigramPred <- function(x) {
        test <- tail(strsplit(x, " ")[[1]], 2)
        bigram=paste(test[1], test[2])
        Xpred=freq2[grep(pattern = paste0("^",bigram," "),x = names(freq2))]
        Xpred = names(Xpred[1])
        paste(substr(Xpred,nchar(bigram)+ 2,nchar(Xpred)))
}

quadgramPred <- function(x) {
        test <- tail(strsplit(x, " ")[[1]], 3)
        trigram=paste(test[1], test[2], test[3])
        Xpred=freq3[grep(pattern = paste0("^",trigram," "),x = names(freq3))]
        Xpred = names(Xpred[1])
        paste(substr(Xpred,nchar(trigram)+ 2,nchar(Xpred)))
}

process_x <- function(x) {
        test=iconv(x, to='ASCII', sub=' ')
        test=process(test)
        test=paste0(test, collapse=" ")
}

getPred=function(x){
        process_x(x)
        words_4 <- quadgramPred(x)
        if (words_4 != "NA") {
                words_4
        } else {
                words_3 <- trigramPred(x)
                if (words_3 != "NA") {
                        words_3
                } else {
                        words_2 <- bigramPred(x)
                        if (words_2 != "NA") {
                                words_2
                        } else {
                                'not found'
                        }
                }
        }
}


