addpath model
data1 = loadData('S2x0');
data2 = loadData('S2x5');
data3 = loadData('S3x0');
%%
addpath view
figure;
visualizeAllSignal(data1, subplot(3, 1, 1));
visualizeAllSignal(data2, subplot(3, 1, 2));
visualizeAllSignal(data3, subplot(3, 1, 3));
%%
observeSNR(data1, data2, data3)
%%
observeAllMetrics(data1, data2, data3)
R = corrcoef(data1.measure, data1.real)
R(1,2)
R = corrcoef(data2.measure, data2.real)
R(1,2)
R = corrcoef(data3.measure, data3.real)
R(1,2)
%%
R = corrcoef(data1.Areal, data1.Aerror)
R(1,2)
R = corrcoef(data2.Areal, data2.Aerror)
R(1,2)

R = corrcoef(data3.Areal, data3.Aerror)
R(1,2)
%%
observeRealInFreq(data1)
%%
figure;
observeMeasureInFreq(data1, subplot(3, 4, 1));  observeRealInFreq(data1, subplot(3, 4, 2));  observeErrorInFreq(data1, subplot(3, 4, 3));  observeAllInFreq(data1, subplot(3, 4, 4));
observeMeasureInFreq(data2, subplot(3, 4, 5));  observeRealInFreq(data2, subplot(3, 4, 6));  observeErrorInFreq(data2, subplot(3, 4, 7));  observeAllInFreq(data2, subplot(3, 4, 8));
observeMeasureInFreq(data3, subplot(3, 4, 9));  observeRealInFreq(data3, subplot(3, 4, 10)); observeErrorInFreq(data3, subplot(3, 4, 11)); observeAllInFreq(data3, subplot(3, 4, 12));
%%
figure;
Settings.getInstance().setXRange([0 10]);
observeMeasureInFreq(data1, subplot(3, 4, 1));  observeRealInFreq(data1, subplot(3, 4, 2));  observeErrorInFreq(data1, subplot(3, 4, 3));  observeAllInFreq(data1, subplot(3, 4, 4));
observeMeasureInFreq(data2, subplot(3, 4, 5));  observeRealInFreq(data2, subplot(3, 4, 6));  observeErrorInFreq(data2, subplot(3, 4, 7));  observeAllInFreq(data2, subplot(3, 4, 8));
observeMeasureInFreq(data3, subplot(3, 4, 9));  observeRealInFreq(data3, subplot(3, 4, 10)); observeErrorInFreq(data3, subplot(3, 4, 11)); observeAllInFreq(data3, subplot(3, 4, 12));
%%
observeFilteredData(data1, butterFilterTest(data1));
observeFilteredData(data2, butterFilterTest(data2));
observeFilteredData(data3, butterFilterTest(data3));
%%
observeFilteredData(data1, butterFilterTest2(data1));
%%
observeFilteredData(data1, firTest1(data1));
%%
function res = calcMSE(predit, trueValue)
res = mean((trueValue- predit) .^ 2)
end