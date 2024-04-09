addpath model
addpath view
data1 = loadData('S2x0');
data2 = loadData('S2x5');
data3 = loadData('S3x0');

addpath algorithm\regression
model1 = FilterTraining(data1.measure, data1.real)
MyFilter(3, model1)
res1 = arrayfun(@(x) MyFilter(x, model1), data1.measure) ;
observeFilteredData(data1, res1)
res1 = arrayfun(@(x) MyFilter(x, model1), data2.measure) ;
observeFilteredData(data2, res1)
res1 = arrayfun(@(x) MyFilter(x, model1), data3.measure) ;
observeFilteredData(data3, res1)