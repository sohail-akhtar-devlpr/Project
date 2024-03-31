
var xhttp = new XMLHttpRequest();

var RazorpayOrderId;

function createOrderIDFunction() {
  
    var amount = document.getElementById("payment_field").value;
   
    xhttp.open("POST", "http://localhost:1617/RevivingLifeDonationBox/OrderCreation?amount=" + amount, true);
  
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  
    xhttp.onreadystatechange = function () {
     
        if (this.readyState === 4 && this.status === 200) {
        
            if (this.responseText) {
              
                RazorpayOrderId = this.responseText;
               
                OpenCheckOut(amount);
               
            } else {
                // alert("Payment creation failed.");
               
            }
        }
    };
   
    xhttp.send();
}


function OpenCheckOut(amount) {
   
    var options = {
        key: "rzp_test_qksO01f0N20twI",
        amount: amount * 100,
        currency: "INR",
        name: "Reviving Life",
        description: "Test Transaction",
        order_id: RazorpayOrderId,
        prefill: {
            name: "",
            email: "",
            contact: ""
        },
        notes: {
            "address": "Razorpay Corporate Office"
        },
        theme: {
            "color": "#3399cc"
        }
    };
   
    var rzp1 = new Razorpay(options);
    rzp1.on('payment.failed', function (response) {
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
    });
   
    rzp1.open();
}
