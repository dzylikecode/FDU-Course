secsLabels = [
    "introduction",
    "methods",
    "results"
    "discussion",
    "conclusion"
    ];
secsWeight = [
    10,
    40,
    20,
    20,
    10
    ];
piechart(secsWeight, secsLabels)
[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
saveas(gcf, sprintf('../figure/%s_%s.png', filename, 'wordCounts'));
secsLabels = [
    "introduction",
    "methods",
    "results"
    "discussion",
    "conclusion"
    ];
secsWeight = [
    25,
    40,
    20,
    20,
    10
    ];
piechart(secsWeight, secsLabels)
[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
saveas(gcf, sprintf('../figure/%s_%s.png', filename, 'citation'));