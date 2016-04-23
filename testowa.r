getPred2=function(x){
        #TEST:
        #x=0
        # Take an input:
        
        test=read.csv("Quiz3.txt",header = F,sep = "\n")
        test=test$V1[x]
        # transform as training set was (lowercase, stem, strip punctuation etc.)
        test=iconv(test, to='ASCII', sub=' ')
        test=process(test)
        test=paste0(test, collapse=" ")
        corpus<-makeCorpus(test)
        corpus=as.character(corpus[[1]][1])
        
        # Split by words:
        words<-unlist(strsplit(corpus,"\\s+"))
        
        # Isolate last two words of the sentence
        # Loop here to make set of 4grams.
        correct=0
        total=length(words)-3
        # how many 4grams will there be? 
        # in a 4 word sentence, 2 so length-2.
        # therefore, need exception not to run this when length is less than 3 words.
        if(length(words)>=4){
                lapply(1:total,FUN=function(x){
                        # loop through sentence making bigram and answer, 
                        trigram=paste(words[x], words[x+1], words[x+2])
                        answer=paste(words[x+3])
                        # then check answer against predicted answer.
                        # Get answer
                        Xpred=freq3[grep(pattern = paste0("^",trigram," "),x = names(freq3))]
                        # isolate the answer from prediction table.
                        Xpred = names(Xpred[1])
                        Xpred=Xpred[length(Xpred)]
                        # Test equality of prediction to actual and counter for the accuracy measure
                        if(!is.na(Xpred)){
                                if(Xpred==paste(trigram,answer)){correct=correct+1}        
                                correct<<-correct
                        } 
                })
        }
        accuracy = correct/total
        # paste("Correct: ", correct, "total: ", total, "Accuracy: ", accuracy)
        return(accuracy)
}