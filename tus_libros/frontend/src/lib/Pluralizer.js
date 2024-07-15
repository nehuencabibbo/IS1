

export default class Pluralizer {

    constructor(count, noun, suffix) {
        this._count = count;
        this._noun = noun;
        this._suffix = suffix;
    }

    static for(count, noun, suffix = 's') {
        return new this(count, noun, suffix)
    }

    value() {
        return `${this._count} ${this._noun}${this._count !== 1 ? this._suffix : ''}`;
    }
}