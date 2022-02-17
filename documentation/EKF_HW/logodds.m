function F = logodds(p)
    F = log10(p) - log10(1-p);
end