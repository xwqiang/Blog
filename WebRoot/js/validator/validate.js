function checkPhone(phone)   
	{
		var ab=/^(13[0-9]|15[0|2|3|6|7|8|9]|18[6|8|9])\d{8}$/;
		var phone = $("#mobilephone").val();
	  	if(ab.test(phone) == false)
	  	{
	  		return false;
	 	}else{
	 		return true;
	 	}
	}
	function checkMail(mail)
	{
	    var t = /(\S)+[@]{1}(\S)+[.]{1}(\w)+/;
	    var mail = mail.trim();
	    
	    if (t.test(mail) == false){
		   
		    return false;
		}else{
			return true;
		}
	}
	function checkQQ(qq)
	{
	    var qq = qq.trim();
		if(qq!=""){		
			var t = /[0-9]{4,13}/;
		    if (t.test(qq) == false){
			    
			    return false;
			}else{
				return true;
			}
		}else
		return true;
	}
	function isNumAndStr(user_pwd){
       var str = user_pwd.trim();
	   var regexpUperStr=/[A-Z]+/;
	   var reexpLowerStr=/[a-z]+/;
	   var regexpNum=/\d+/;
	   var regexpLen =/\w{8,50}/;
	   var uperStrFlag = regexpUperStr.test(str);
	   var lowerStrFlag = reexpLowerStr.test(str);
	   var numFlag = regexpNum.test(str);
	   var lenFlag = regexpLen.test(str);
	   if(!lenFlag){
	   		
	   		return false;
	   }else if((lowerStrFlag&&numFlag)||(uperStrFlag&&numFlag)){
	   		
	      	return true;
	   }else{
		   
		   return false;
	   }
   	}