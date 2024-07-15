import ModernSoftwareEngineering from "./prototypes/ModernSoftwareEngineering.jpg";
import ExtremeProgrammingExplained from "./prototypes/ExtremeProgrammingExplained.jpg";
import PlanningExtremeProgramming from "./prototypes/PlanningExtremeProgramming.jpg";
import DomainDrivenDesign from "./prototypes/DomainDrivenDesign.jpg";
import ObjectThinking from "./prototypes/ObjectThinking.jpeg";
import TestDrivenDevelopmentByExample from "./prototypes/TestDrivenDevelopmentByExample.jpg";
import {TusLibrosRestInterface} from "./interface/TusLibrosRestInterface";
import {FakeRequester} from "@eryxcoop/appyx-comm";
import NaiveAuthorizationManager from "./interface/communication/NaiveAuthorizationManager";
import RemoteRequester from "./interface/communication/RemoteRequester";


export class App {

    constructor() {
        this._restInterface = null;
        this._apiUrl = 'http://localhost:9000';
    }

    books() {
        return [
            {
                isbn: '9780137314942',
                cover: ModernSoftwareEngineering,
                // cover: "https://source.unsplash.com/random?wallpapers",
                title: 'Modern Software Engineering',
                description: 'In Modern Software Engineering, continuous delivery pioneer David Farley helps ' +
                    'software professionals think about their work more effectively, manage it more successfully, ' +
                    'and genuinely improve the quality of their applications, their lives, and the lives of their' +
                    ' colleagues.',
                score: 4.5,
                price: '31.505'
            },
            {
                isbn: '9780321278654',
                cover: ExtremeProgrammingExplained,
                title: 'Extreme Programming Explained',
                description: 'Software development projects can be fun, productive, and even daring. Yet they can ' +
                    'consistently deliver value to a business and remain under control.',
                score: 4,
                price: '45.305'
            },
            {
                isbn: '9780201710915',
                cover: PlanningExtremeProgramming,
                title: 'Planning Extreme Programming',
                description: 'Planning is critical; without it, software projects can quickly fall apart. Written by ' +
                    'acknowledged XP authorities Kent Beck and Martin Fowler, Planning Extreme',
                score: 3.5,
                price: '45.180'
            },
            {
                isbn: '9780321125217',
                cover: DomainDrivenDesign,
                title: 'Domain-Driven Design',
                description: 'Eric Evans has written a fantastic book on how you can make the design of your ' +
                    'software match your mental model of the problem domain you are addressing',
                score: 3,
                price: '41.000'
            },
            {
                isbn: '9780735619654',
                cover: ObjectThinking,
                title: 'Object Thinking',
                description: 'In OBJECT THINKING, esteemed object technologist David West contends that the mindset ' +
                    'makes the programmer—not the tools and techniques. Delving into the history, philosophy, ' +
                    'and even politics of object-oriented programming',
                score: 3,
                price: '34.900'
            },
            {
                isbn: '9780321146533',
                cover: TestDrivenDevelopmentByExample,
                title: 'Test Driven Development: By Example',
                description: 'Quite simply, test-driven development is meant to eliminate fear in application ' +
                    'development. While some fear is healthy (often viewed as a conscience that tells programmers ' +
                    'to "be careful!"), the author believes that byproducts of fear include tentative, grumpy, and ' +
                    'uncommunicative programmers who are unable to absorb constructive criticism. ',
                score: 4,
                price: '29.100'
            },
        ];
    }

    bookWithIsbn(anIsbn) {
        return this.books().find( (each) => each.isbn === anIsbn );
    }

    createCart(aClientId, aPassword){
        return this._interface().createCart(aClientId, aPassword)
    }

    listCart(aCartId){
        return this._interface().listCart(aCartId)
    }

    addToCart(aBook, aQuantity, aCart){
        return this._interface().addToCart(aBook, aQuantity, aCart)
    }

    checkout(aCard, aCart) {
        return this._interface().checkout(aCard, aCart);
    }

    listPurchases(aClientId, aPassword){
        return this._interface().listPurchases(aClientId, aPassword)
    }

    totalOf(items) {
        return items.reduce( (total, anItem) => total + this._priceOf(anItem), 0)
    }

    _priceOf(anItem){
        const price = parseFloat(anItem.article.price.replace('.', ''));
        const quantity = parseInt(anItem.quantity);
        return price * quantity
    }

    "Privates"
    _interface() {
        if (this._restInterface === null) {
            this._setUpRestInterface();
        }

        return this._restInterface;
    }

    _setUpRestInterface() {
        const requester = this._setUpRequester();
        this._restInterface = new TusLibrosRestInterface(requester);
    }

    _setUpRequester() {
        if (this._isUsingFakeApi()) {
            return new FakeRequester();
        }

        const authorizationManager = new NaiveAuthorizationManager();
        return new RemoteRequester(this._apiUrl, authorizationManager);
    }

    _isUsingFakeApi() {
        return false;
    }

}