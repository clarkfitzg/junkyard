// Dummy data for testing
var intensity = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]

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

// Define the color mapping
var color = d3.scale.linear()
    .domain([0, 1])
    .range(["white", "red"]);

// Create an arc svg element?
var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

// Layout the arcs in an evenly spaced pie
var pie = d3.layout.pie()
    .value(function(i) { return 1; });

// Start drawing on the donut
var g = svg.selectAll(".arc")   // CSS3 selector for all elements with class arc
    .data(pie(intensity))       // Defines what the default data are
    .enter().append("g")        // Add a "g" element for each datum d_i
    .attr("class", "arc")       // Set the class of these elements to "arc"
    .append("path")             // Add a path element under "g"
    .attr("d", arc)             // Set the "d" attribute to arc(d_i)
    .style("fill", color(0.5)); // default color since want to animate updates

// No need to .enter() here since nodes exist
g.data(intensity)
    .transition().duration(3000)  // A long transition
    .style("fill", color);