// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var imagebox=document.getElementById("imagebox")
var imageselect=document.getElementById("imageselect")
var imagelist=[image_tag product.photo.url(:thumb)]

imageselect.onchange=function(){
  if (this.selectedIndex!=0){
    imagebox.src=imagelist[this.selectedIndex-1]
      jQuery(imagebox).imageMagnify({
magnifyby: 2
})
}
}

