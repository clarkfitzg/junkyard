library('RUnit')

onlyintegers = function(string)
{
    # Return all the integers in a string

    # Code goes here...
}
RUnit::checkEquals(onlyintegers(' hey 10!  '), 10)
