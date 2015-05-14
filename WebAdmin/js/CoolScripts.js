function ticker(element, stepper) {
    var start = 0
            , max = 3689
            , step = 1
            , refreshRate = 50 // ms
            , number = start
            //, el = document.getElementById('displayField')
            , el = element
            , growNumber = function () {
                number += step;
                step += stepper;
                el.innerHTML = number; // you might want to format it to your liking here
                if (number + step >= max) {
                    number = max;
                    el.innerHTML = number;
                    clearInterval(timerId);
                }
            }
            , timerId = setInterval(growNumber, refreshRate);
    growNumber();
}