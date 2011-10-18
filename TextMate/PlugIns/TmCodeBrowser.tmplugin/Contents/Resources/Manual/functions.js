var	namedAnchors=new Array();
var highlightedAnchor=null;

function addClass(object,className)
{
	removeClass(object,className);
	if(object.className.length>0) object.className+=' ';
	object.className+=className;
}

function removeClass(object,className)
{
	var re=new RegExp("^"+className+"\\b\\s*|\\s*\\b"+className+"\\b",'g');
	object.className=object.className.replace(re,'');
}

function initAnchors()
{
	//window.console.log("initAnchors called");
	for(i=0;i<document.anchors.length;i++)
	{
		var anchor=document.anchors[i];
		var name=anchor.getAttribute('name');
		if(name!=null)
		{
			//window.console.log("named anchor found: "+name);
			namedAnchors[name]=anchor;
		}
	}
}

function initLinks()
{
	//window.console.log("initLinks called");
	for(i=0;i<document.links.length;i++)
	{
		//window.console.log("i="+i);
		var link=document.links[i];
		var href=link.getAttribute('href');
		if(href!=null && href.indexOf('#')==0)
		{
			//window.console.log("link with href found: "+href);
			var name=href.substring(1);
			var evn="highlightAnchor('"+name+"')";
			var fun=new Function('e',evn);
			link.onclick=fun;
		}
	}
}

function clearHighlight()
{
	if(highlightedAnchor!=null)
	{
		removeClass(highlightedAnchor,'highlight');
		highlightedAnchor=null;
	}
}

function highlightAnchor(name)
{
	clearHighlight();
	
	var anchor=namedAnchors[name];
	if(anchor!=null)
	{
		addClass(anchor,'highlight');
		highlightedAnchor=anchor;
	}
}

window.onload=function()
{
	//window.console.log("window.onload");
	initAnchors();
	initLinks();
	highlightAnchor(location.hash.substring(1));
}

window.onblur=function()
{
	//window.console.log("window.onblur");
	clearHighlight();
}
