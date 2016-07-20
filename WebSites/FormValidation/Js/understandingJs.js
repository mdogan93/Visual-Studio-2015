
/*
 Basic "this" example
*/
    function clickMe() {
        function foo() {
            console.log(this); //global object
        };
        foo();

        myapp = {"prop1": "val1" , "prop2" : "val2"};
        myapp.foo = function () {
            console.log(this); //points to myapp object
        }
        myapp.foo();
    }

//#########------------------#############
/*
 Basic Scope Example
*/
    var name = 'globe';
var myFunction = function () {
    var name = 'level1';
    var myFuncLevel2 = function () {
        console.log(name+" inner");
    };
    console.log(name+" outer");
    myFuncLevel2(); //output is "level1 inner"
};
         
//myFunction.call(this);//this is "window" output is "level1 outer"
//console.log(name);//globe

//#########------------------#############
/*
    Low-level complex scope
*/
    $(document).ready(function () {
        var nav = document.querySelector('.nav'); // <nav class="nav">
        var toggleNav = function () {
            console.log(this); // <nav> element
            var _this = this; // to store this value for later call
            setTimeout(function () {
                console.log(_this); // [object Window]
            }, 5000);
        };
        nav.addEventListener('click', toggleNav, false);
    });
//#########------------------#############
/*
    Self - invoking example
*/
    var sayHello = (function (name) {
        var text = 'Hello, ' + name;
        return function () {
            console.log(text);
            //sayHello(); // infinite call
                
        };
    })("roro");
//sayHello(); // call for self invoking function
//sayHello('Todd')(); //call for non-self-invoking

//#########------------------#############
/*
    Call example
*/
    $(document).ready(function () {
        var links = document.querySelectorAll('ul li');
        for (var i = 0; i < links.length; i++) {
            (function () {
                console.log(this);
            }).call(links[i]);
        }
    })

//#########------------------#############         
/*
    Module template
*/
    var Module = (function () {
        var myModule = {};
        var privateMethod = function () {
            alert("private");
        };
        myModule.publicMethod = function () {
            alert("public method 1")
        };
        myModule.anotherPublicMethod = function () {
            alert("public method 2")
        };
        return myModule; // returns the Object with public methods
    })();

// Module.publicMethod();  // call for public method

//#########------------------#############
/*
    Closure Property
*/
    function myModule() {
        var name = "tim", age = 28;
        return function greet() {
            return "Hello " + name + ".  Wow, you are " + age + " years old.";
        }
    }
        
    //var greeter = myModule();   // call `myModule` to get a closure out of it.
    //alert(greeter());           // Call the closure

    //alert(myModule()());      // another option to call the closure

//#########------------------#############
/*
   Apply And Scope 
*/
    var person = {
        firstName   :"Penelope",
        lastName    :"Barrymore",
        showFullName:function() {
            console.log(this.firstName + " " + this.lastName);
        }
    };
//person.showFullName(); // Penelope Barrymore
var anotherPerson = {
    firstName: "mary",
    lastName:"gary"
}
//person.showFullName.apply(anotherPerson);

//#########------------------#############

/*
    Call - Bind - Scope
*/
var data = [
{name:"Samantha", age:12},
{name:"Alexis", age:14}
]
var user = {
    data: [
                { name: "T. Woods", age: 37 },
                { name: "P. Mickelson", age: 43 }
    ],
    showData: function (event) {
        var randomNum = ((Math.random() * 2 | 0) + 1) - 1;
        console.log(this.data[randomNum].name + " " + this.data[randomNum].age );
    }
}
//user.showData(); // call for the global scope 
//user.showData.call(user); // call for the local "user" scope
//user.showData.bind(user)(); // call after binding "user" scope  


//#########------------------#############
{
    /*
        Understanding Prototype
    */
    var alien = {
        kind: 'alien'
    }

    // and a person object
    var person = {
        kind: 'person'
    }

    // and an object called 'zack'
    var zack = {};

    // assign alien as the prototype of zack
    zack.__proto__ = alien

    // zack is now linked to alien
    // it 'inherits' the properties of alien
    //console.log(zack.kind); //=> ‘alien’

    // assign person as the prototype of zack
    zack.__proto__ = person

    // and now zack is linked to person
    //console.log(zack.kind); //=> ‘person’

    /*

    */
    function Person(name) {
        this.name = name;
    }

    // the function person has a prototype property
    // we can add properties to this function prototype
    Person.prototype.kind = 'person'

    // when we create a new object using new
    var zack = new Person('Zack');

    // the prototype of the new object points to person.prototype
    zack.__proto__ == Person.prototype //=> true

    // in the new object we have access to properties defined in Person.prototype
    zack.kind //=> person



    var Vehicle = function Vehicle(color) {
        this.constructor;       // function Vehicle()
        this.color = color;
    }

//alert((new Vehicle("tan")).color);   // "tan"

}

/*
        CallBack function
*/

var allUserData = [];

//function logStuff(userData){
//    if( typeof userData === "string"){
//        console.log(userData);
//    }
//    else if( typeof userData === "object"){
//        for(var item in userData){
//            console.log(item + ": " + userData[item]);
//        }
//    }
//}
//function getInput(options,callback){
//    allUserData.push(options);
//    callback(options);
//}
//getInput({
//    name: "Rich",
//    speciality: "js"
//}, logStuff);

//console.log(allUserData);

function getInput(options) {
    allUserData.push(options,
     (function(){
         for (var item in options) {
             console.log(item + " : " + options[item]);
         }

     })());
}


getInput({
    name: "Rich",
    speciality: "js"
});


function some_function2(url, callback) {
    var httpRequest; // create our XMLHttpRequest object
    if (window.XMLHttpRequest) {
        httpRequest = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        // Internet Explorer is stupid
        httpRequest = new
			ActiveXObject("Microsoft.XMLHTTP");
    }

    httpRequest.onreadystatechange = function() {
        // inline function to check the status
        // of our request
        // this is called on every state change
        if (httpRequest.readyState === 4 && httpRequest.status === 200) {
            callback.call(httpRequest.responseXML);
            // call the callback function
        }
    };
    httpRequest.open('GET', url);
    httpRequest.send();
}
// call the function
some_function2("../note.xml", function () {
    console.log(this);
});
console.log("this will run before the above callback");