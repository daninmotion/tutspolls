var Graph = function (selector, data, kind) {
	this.selector = selector; 
	this.data = data; 
	this.kind = kind;
};

Graph.prototype.getData = function() {
	var _this = this;
	var dataWithCaptions = this.data.data.map(function(element, index, array) {
		return [ _this.data.x_axis.series[index], element];
	}); //[ ["Jan 2014", 5 ], [ "Feb 2014", 2 ] ]

	return google.visualization.arrayToDataTable([ 
		[ this.data.x_axis.legend, this.data.y_axis.legend ], 
	].contact(dataWithCaptions));

	return data;
}

Graph.prototype.getkind = function() {
	var kinds = {
		"column" : "ColumnChart"
		"pie" : "PieChart"
	};

	return kinds[this.kind];
}

Graph.prototype.render = function() {
	// Set chart options
	var options = {'title': this.data.title,
	'width':400, 'height':300};

	//Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization[Graph.graphs[this.kind]]($(this.selector)[0]);
	chart.draw(this.getData(), options);
};

Graph.instances = [];