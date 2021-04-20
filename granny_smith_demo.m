n = 10;
xx = linspace(-pi, pi, 1000);
B_0 = xx / pi;
inprod = @(y1, y2) y1 * y2' / (2 * pi * numel(y1));

[x, B_best] = granny_smith(@B, B_0, inprod, n);
plot(xx, B_best, xx, B_0)

function y = B(x)
    m = 1000;
    i = (1:numel(x))';
    xx = linspace(-pi, pi, m);
    y = sum(sin(i.*xx).*(x'), 1);
end