# too long don't read

## week 6

- [The Fast Fourier Transform Algorithm - YouTube](https://www.youtube.com/watch?v=toj_IoCQE-4) explains FFT algorithm in the matrix way, [MIT—线性代数笔记 26 复矩阵；快速傅里叶变换 - 知乎](https://zhuanlan.zhihu.com/p/46041373) 给出一些解释, [20、傅里叶变换、快速傅里叶 FFT - 知乎](https://zhuanlan.zhihu.com/p/41499711?utm_id=0), [FFT 与傅里叶矩阵 - 知乎](https://zhuanlan.zhihu.com/p/517939127?utm_id=0), [快速傅里叶变换（fft）的矩阵理解和在 numpy 中的举例说明 - 知乎](https://zhuanlan.zhihu.com/p/340208635?utm_id=0)给出了新的运算视角
- [Fast Fourier transform - Algorithms for Competitive Programming](https://cp-algorithms.com/algebra/fft.html) implementation of FFT algorithm
- [fourier.dvi](https://www.cs.cmu.edu/afs/andrew/scs/cs/15-463/2001/pub/www/notes/fourier/fourier.pdf) comprehensive
- [一小时学会快速傅里叶变换（Fast Fourier Transform） - 知乎](https://zhuanlan.zhihu.com/p/31584464)

  $$\omega_{2n}^{2k}=\omega_{n}^{k}$$ 实现递归

需要理解:

- 最底层如何排序: 码位倒置
- 向上操作: 蝶形操作
