library(shiny)

shinyServer(function(input, output) {
  modeltemp<-lm(Ozone~Temp,data = airquality)
  modelwind<-lm(Ozone~Wind,data = airquality)
  modelboth<-lm(Ozone~Temp+Wind, data = airquality)
  
  modeltemppred<-reactive({
    tempInput<-input$numtemp
    predict(modeltemp,newdata=data.frame(Temp=tempInput))
  })
  
  modelwindpred<-reactive({
    windInput<-input$numwind
    predict(modelwind,newdata=data.frame(Wind=windInput))
  })
  
  modelbothpred<-reactive({
    tempInput<-input$numtemp
    windInput<-input$numwind
    predict(modelboth,newdata=data.frame(Temp=tempInput,Wind=windInput))
  })
  
  output$plot1 <- renderPlot({
    tempInput<-input$numtemp
    if(input$showtempmodel){
      with(airquality,plot(Temp,Ozone,xlab="Temperature",ylab="Ozone",main="Temperature versus Ozone",pch=20,xlim=c(40,110)))
      abline(modeltemp,col="blue",lwd=2)
      points(tempInput,modeltemppred(),col="red",pch=15)
    }
  })
  
  output$plot2 <- renderPlot({
    windInput<-input$numwind
    if(input$showwindmodel){
      with(airquality,plot(Wind,Ozone,xlab="Wind",ylab="Ozone",main="Wind Speed versus Ozone",pch=20,xlim=c(-1,26)))
      abline(modelwind,col="blue",lwd=2)
      points(windInput,modelwindpred(),col="red",pch=15)
    }
  })
  
  output$plot3 <- renderPlot({
    windInput<-input$numwind
    tempInput<-input$numtemp
    if(input$showbothmodel){
      library(plot3D)
      with(airquality,scatter3D(Temp,Wind,Ozone,pch=20,size=3,xlab="Temperature",ylab="Wind Speed",zlab="Ozone"))
      scatter3D(tempInput,windInput,modelbothpred(),col="red",pch=15,size=3,add=TRUE)
    }
    
  })
  
  output$pred1 <- renderText({
    if(input$showtempmodel){
      modeltemppred()
    }
    else{
      "No prediction requested"
    }
  })
  
  output$pred2 <- renderText({
    if(input$showwindmodel){
      modelwindpred()
    }
    else{
      "No prediction requested"
    }
  })
  
  output$pred3 <- renderText({
    if(input$showbothmodel){
      modelbothpred()
    }
    else {
      "No prediction requested"
    }
  })
})
