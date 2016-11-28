// Set up the canvas
width = 500;
height = 500; // TODO change to more pleasant
radius = Math.min(width, height) / 2;

// Define a linear map from [0, 1] -> [white, red]
color = d3.scale.linear()
    .domain([0, 1])
    .range(["white", "red"]);

// Define a function used in making arcs
arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

// Layout the arcs in an evenly spaced pie
pie = d3.layout.pie()
    .value(function(i) { return 1; });

// Add the run button
d3.select("body")
    .insert("button", "p")
    .on("click", animate)
    .html("Run");

/**
 * Read all user inputs
 */
function html_inputs() {

    // + operator casts to float
    dt = +d3.select("#dt").attr("value");
    dx = +d3.select("#dx").attr("value");
    duration = +d3.select("#duration").attr("value");
    u_f = +d3.select("#u_f").attr("value");
    k_j = +d3.select("#k_j").attr("value");
    c_j = +d3.select("#c_j").attr("value");

    // initial density in regions (quadrants)
    density0 = d3.select("#density0").attr("value");
    density0 = d3.csv.parseRows(density0)[0].map(Number);

    // Want a fixed number of dx's in each region
    roadlength = 5280 * +d3.select("#roadlength").attr("value");
    dx_perquad = Math.round(roadlength / (density0.length * dx));

    // density in each fixed area
    function densitydx(d, nregion = dx_perquad){
        return Array(nregion).fill(d);
    };

    density = density0.map(densitydx);

};


/**
 * Create svg
 */
function setup() {

    html_inputs();

    // Add the svg element into the body of the document with appropriate
    // parameters
    svg = d3.select("body").append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    // Start drawing on the donut
    svg = svg.selectAll(".arc")           // CSS3 selector for all elements with class arc
        .data(pie(density))        // pie() works with arc()
        .enter()                    // Operate on the elements that don't yet exist
        .append("g")                // Add a "g" element for each datum d_i
        .attr("class", "arc")       // Set the class of these elements to "arc"
        .append("path")             // Add a path element under "g"
        .attr("d", arc)            // Set the "d" attribute to arc(d_i)

    // Add the starting color
    svg.data(density)
        .style("fill", color);

    return svg;
};


/**
 * Traffic demand to enter next cell
 * @param {Array} density in each cell
 * @param {Number} max 
 * @return {Array} demand in units of cars
 */
function demand(cells, kmax = kmax, qmax = qmax) {
}


function animate() {

    svg.data([0.5, 0.5, 0, 0])  // intensity is now the data {d_i}
        .transition()           //
        .duration(1000 * dt)        // transition length in ms
        .style("fill", color);   // set fill style i to color(d_i)
};


// Action happens here
setup();
