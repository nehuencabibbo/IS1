

Number.prototype.range = function (stop, step) {
    const start = this;
    return Array.from({length: (stop - start) / step + 1}, (_, i) => start + (i * step));
};

Number.prototype.max = function (aNumber) {
    return Math.max(this, aNumber);
};