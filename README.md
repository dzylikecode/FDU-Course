# 复旦课程

工研院

$$
\frac {\mathrm{d} life} {\mathrm{d} t} =
\begin{cases}
📕\text{(study)} &\quad \text{if your boss observes you}  \\
🐟\text{(slack off)} &\quad \text{if your lover observes you}
\end{cases}
$$

## 模式

### 非文本文件

git repository 存放个人自己所做的, 而 pdf 等之类的就 ignore, 最后将整体(pdf 之类的)放到网盘

技巧:

- 指定放入网盘的文件名满足`*-pan`的形式

### mlx 文件

- 使用[dzylikecode/matlab-file-converter](https://github.com/dzylikecode/matlab-file-converter)转化为 .m 文件上传到 GitHub, 而 .mlx 忽略
- 在 matlab 中 .m 文件可以方便地以 .mlx 形式打开

  ![](assets/2023-09-25-08-15-46.png)

- 作业提交的时候, 可以两种形式一起提交, 方便查看, 用[dzylikecode/matlab-file-converter](https://github.com/dzylikecode/matlab-file-converter)转化

将这个步骤脚本化

### code

#### 自动保存图像

matlab:

```matlab
[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
saveas(gcf, sprintf('../figure/%s_%s.png', filename, imgName));
```

mathematica:

```wl
fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName]
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];

fig02 = Plot[Hfabs, {f, - (fs/2), fs/2}]
Export[SetName["1"], fig02];
```

- 使用 drawio 画图, 保存为 svg
- [如何复制知乎文章中的公式 - 清北博客](https://blog.tsinbei.com/archives/1152/#mjx-eqn-eq)
- [MathType demo - For Developers](https://demo.wiris.com/mathtype/en/developers.php?_ga=2.154018814.778037287.1696334679-1067626557.1696334679)
- 学会使用 mathtype 提高公式编辑速度
- 自动生成作业模板

### 突出主逻辑

艺术性, 左边是主逻辑, 右边是 observe

```matlab
function X = FFT_prime(xs)
theta = reArrange(xs);                          ; theta = sym(theta)
while getCols(theta) ~= 1
                                                ; disp('---------' + string(getRows(theta)));
    [alpha, beta] = partition(theta);           ; alpha, beta
    rotateM = rotateMatrix(getRows(theta));     ; W = sym(rotateM)
    phi_1 = alpha + rotateM*beta;
    phi_2 = alpha - rotateM*beta;
    theta = [phi_1; phi_2];                     ; simplify(theta)
end
X = theta;
end
```

## 思考

```matlab
labels = [
    draw(@(x) x, 'k');
    draw(f_curry(2), 'b');
    draw(f_curry(1/4), 'r');
    draw(f_curry(0), 'c');
    draw(f_curry(-3), 'g');
    ];
```

有点意思, 一行一行的语句, 可以看作是列向量, 仅仅是形式上而已, 用的不过是返回值

## References

- [npubird/KnowledgeGraphCourse: 东南大学《知识图谱》研究生课程](https://github.com/npubird/KnowledgeGraphCourse)
- [致谢 - 《SEU 生存指南 2.0 - 东南大学生存指南 2.0》 - 极客文档](https://geekdaxue.co/read/chengqing-ddfhl@ckpcv7/cr8aqk)
- [README - SurviveSJTUManual](https://survivesjtu.gitbook.io/survivesjtumanual/)
- [Xin Peng's Homepage](https://cspengxin.github.io/)
- [Zhemin Yang](https://yangzhemin.github.io/)
