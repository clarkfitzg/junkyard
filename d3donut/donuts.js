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
    .range(["green", "red"]);

// Create an arc svg element?
var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

// Layout the arcs in an evenly spaced pie
var pie = d3.layout.pie()
    .value(function(i) { return 1; });

// select the arc elements
var g = svg.selectAll(".arc")
    .data(pie(intensity))
    .enter().append("g")
    .attr("class", "arc");

g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { return color(0.5); });
