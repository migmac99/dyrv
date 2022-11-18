function hashCode(str){ 
  return (str.split('').reduce((agg, x)=>{  
    agg = (agg << 5) - agg + x.charCodeAt(0);  
    return Math.abs(agg & agg) }, 0) 
  )}; 
console.log(hashCode(process.argv[2] + '9Z8d*s42fDhi'))