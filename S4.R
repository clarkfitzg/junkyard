setClass('funstuff', slots = list(words = 'character', numbers = 'numeric'))
a = new('funstuff', words = 'a here', numbers = 20)

# Nice- throws an error
#a@cool

setMethod('initialize', 'funstuff', function(.object){
    .object@words = 'went through initialize'
    .object@numbers = 'went through initialize'
})

