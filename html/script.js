let notify = false
let defaultnumber = 0;
window.addEventListener('message', (event) => {
    var data = event.data
    if (data.type === 'moneyHud') {
        var walletMoney = Intl.NumberFormat('de-DE').format(data.walletMoney)
        $('#walletMoney').html(walletMoney+'<div class="currency" id="currency1">RON</div>')
        var bankMoney = Intl.NumberFormat('de-DE').format(data.bankMoney)
        $('#bankMoney').html(bankMoney+'<div class="currency" id="currency2">RON</div>')
        $('#userID').html('ID: '+ data.userID)
        function addZero(i) {
            if (i < 10) {i = "0" + i}
            return i;
        }
        const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
        const d = new Date();
        let h = addZero(d.getHours());
        let m = addZero(d.getMinutes());
        let y = addZero(d.getFullYear());
        let month = months[d.getMonth()];
        let day = addZero(d.getDate());
        let time = h + ":" + m;
        let date = day+" "+ month+" "+y;
        $('#timeClock').html(time+'<div class="clockIcon"></div>')
        $('#clock').html(time)
        $('#date').html(date)
    }  else if (data.type === 'notifyBank') {
        var audio = new Audio("./sounds/bankNotify.mp3");
        audio.volume = 0.35; //0.0-1.0
        audio.play();
        $('#textNotify').html('received in your bank')
        var amount = Intl.NumberFormat('de-DE').format(data.amount)
        $('#amountBank').html('+'+amount)
        $("#Notify").fadeIn(500)
        setTimeout(function() {
            $('#Notify').fadeOut(500)
        }, 2000)
    }
    else if (data.type === 'notifyWallet') {
        var audio = new Audio("./sounds/bankNotify.mp3");
        audio.volume = 0.35; //0.0-1.0
        audio.play();
        $('#textNotify').html('received in your wallet')
        var amount = Intl.NumberFormat('de-DE').format(data.amount)
        $('#amountBank').html('+'+amount)
        $("#Notify").fadeIn(500)
        setTimeout(function() {
            $('#Notify').fadeOut(500)
        }, 2000)
    }else if(data.type === 'notifySentBank'){
        var audio = new Audio("./sounds/sentNotify.mp3");
        audio.volume = 0.35; //0.0-1.0
        audio.play();
        $('#textSent').html(' sent to other account')
        var amount = Intl.NumberFormat('de-DE').format(data.amount)
        $('#amountSent').html('-'+amount)
        $("#sentNotify").fadeIn(500)
        setTimeout(function() {
            $('#sentNotify').fadeOut(500)
        }, 2000)
    }else if(data.type === 'notifySentWallet'){
        var audio = new Audio("./sounds/sentNotify.mp3");
        audio.volume = 0.35; //0.0-1.0
        audio.play();
        $('#textSent').html('sent to another wallet')
        var amount = Intl.NumberFormat('de-DE').format(data.amount)
        $('#amountSent').html('-'+amount)
        $("#sentNotify").fadeIn(500)
        setTimeout(function() {
            $('#sentNotify').fadeOut(500)
        }, 2000)
    }else if(data.type == "infoNotify"){
        if (notify == false){
            var audio = new Audio("./sounds/textNotify.mp3");
            audio.volume = 0.35; //0.0-1.0
            audio.play();
            $('#title').html(data.title)
            $('#notification-text').html(data.text)
            let progr = document.getElementById('progress');
            let progress = 1;
            let time = data.duration/50
            let id = setInterval(frame, time);
                    $("#infoNotify").css('display', 'flex')
                    notify = true
                    function frame() {
                        if(progress == 13.5){
                            $("#infoNotify").fadeOut(250)
                            clearInterval(id);
                            notify = false
                            $('#counter').hide()
                            $('#number').html("0")
                        } else {
                            progress += 0.25;
                            progr.style.width = progress + 'vw'
                        }
            }
        }else {
            $('#counter').show()
            defaultnumber += 1;
            $('#number').html(defaultnumber)
        }
    }else if(data.type === "zoneUpdate"){
        $('#street').html(data.zoneName)
        $('#zone').html(data.streetName)
    }
});

var speedText = ''

window.addEventListener("message", function(event) {
	var item = event.data

	if (item.ShowHud) {

		s_Rpm = item.CurrentCarRPM
		s_Gear = item.CurrentCarGear
		s_fuelamount = item.CurrentCarFuelAmount
		s_Handbrake = item.CurrentCarHandbrake
		s_Brake = item.CurrentCarBrake
		s_Speed = item.CurrentCarSpeed
		
		$("#rpmshow").attr("data-value", s_Rpm.toFixed(2))
		if(s_Gear == 0) {
			$(".geardisplay span").html("R")
			$(".geardisplay").attr("style", "color: rgba(255,255,255,0.5)border-color:rgba(255,255,255,0.5)")
		} else {
			$(".geardisplay span").html(s_Gear)
			if(s_Rpm > 7.5) {
				$(".geardisplay").attr("style", "color: rgba(235,5,61,0.5)border-color:rgba(235,5,61,.5)")
			} else {
				$(".geardisplay").removeAttr("style")
			}
		}
		if (s_Speed > 999) {
			s_Speed = 999
		} else if(s_Speed >= 100) {
			var tmpSpeed = Math.floor(s_Speed) + ''
			speedText = '<span class="int1">' + tmpSpeed.substr(0, 1) + '</span><span class="int2">' + tmpSpeed.substr(1, 1) + '</span><span class="int3">' + tmpSpeed.substr(2, 1) + '</span>'
		} else if(s_Speed > 9 && s_Speed <= 99) {
			var tmpSpeed = Math.floor(s_Speed) + ''
			speedText = '<span class="gray int1">0</span><span class="int2">' + tmpSpeed.substr(0, 1) + '</span><span class="int3">' + tmpSpeed.substr(1, 1) + '</span>'
		} else if(s_Speed > 0 && s_Speed <= 9) {
			speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="int3">' + Math.floor(s_Speed) + '</span>'
		} else {
			speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="gray int3">0</span>'
		}
		if(s_Handbrake) {
			$(".handbrake").html("HBK")
		} else {
			$(".handbrake").html('<span class="gray">HBK</span>')
		}

		if(s_fuelamount != 0) {
			$(".fuel").html('GAS<span class="gray" style="margin-left: 5px">'+s_fuelamount+'</span>')
		}
		if(s_Brake > 0) {
			$(".abs").html("ABS")
		} else {
			$(".abs").html('<span class="gray">ABS</span>')
		}
		$(".speeddisplay").html(speedText)
		$("#container").fadeIn(500)

	} else if (item.HideHud) {
		$("#container").fadeOut(500)
	}
})
