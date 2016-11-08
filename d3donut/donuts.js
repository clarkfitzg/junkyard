//var intensity = d3.csv.parseRows("1,0\n0,1");

d3.text("sin.csv", function(d) {
    intensity = d3.csv.parseRows(d, function(row) {
        return row.map(parseFloat)
    });
});

/*
// User input determines transition time ttime
d3.select("#intensity").on("input", function() {
    intensity2 = +this.value;
});


// Dummy data for testing

d3.select("#intensity").on("input", function() {
    //intensity = d3.csv(this.value);
    console.log("in the middle now")
});
*/



// Set up the canvas
var width = 500,
    height = 500, // TODO change to more pleasant
    radius = Math.min(width, height) / 2;

// Add the svg element into the body of the document with appropriate
// parameters
var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

// Define a linear map from [0, 1] -> [white, red]
var color = d3.scale.linear()
    .domain([0, 1])
    .range(["white", "red"]);

// Define a function used in making arcs
var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

// Layout the arcs in an evenly spaced pie
var pie = d3.layout.pie()
    .value(function(i) { return 1; });

// Add the run button
d3.select("body")
    .insert("button", "p")
    .on("click", animate)
    .html("Run");

// default length of transition converted to ms
// + operator casts to float
var ttime = 1000 * +d3.select("#ttime").attr("value");

// Update variable when the user picks a new one
d3.select("#ttime").on("input", function() {
      ttime = 1000 * +this.value;
});

function setup() {

    // Start drawing on the donut
    return svg.selectAll(".arc")   // CSS3 selector for all elements with class arc
        .data(pie(intensity[0]))    // Defines the default data {d_i}
        .enter()                    // Operate on the elements that don't yet exist
        .append("g")                // Add a "g" element for each datum d_i
        .attr("class", "arc")       // Set the class of these elements to "arc"
        .append("path")             // Add a path element under "g"
        .attr("d", arc)             // Set the "d" attribute to arc(d_i)
        .style("fill", color(0.1)); // default color since want to animate updates
};

function animate() {

    g = setup()

    // Loop over each row in intensity
    intensity.forEach(function(row, index) {
        // No need to .enter() here since nodes exist
        g.data(row)                 // intensity is now the data {d_i}
            .transition()           //
            .duration(ttime)        // transition length in ms
            .delay(index * ttime)   // Should happen sequentially
            .style("fill", color)   // set fill style i to color(d_i)
    });
};
