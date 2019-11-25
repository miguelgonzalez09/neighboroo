//*= require mapbox-gl
//= require algolia/v3/algoliasearch.min
//= require rails-ujs
//= require_tree .

var client = algoliasearch('3EG2SOA15K', '024010d4d989e28aa20dd669ace79423');
var index = client.initIndex('Item');
let searchVar = document.querySelector("#query");
const results = document.getElementById('results')
console.log(results)
searchVar.addEventListener("input", (e) => {
    
    index.search(e.target.value, { hitsPerPage: 10, page: 0 })
      .then(function searchDone(content) {
        console.log(e.target.value)
        if (content.hits.length !== 0){
          results.innerText = '';
        } 

        if (e.target.value === ""){
          results.innerText = '';
        } else {
          content.hits.forEach((hit) => {
            results.insertAdjacentHTML('beforeEnd', `<p>${hit.name}</p><p>${hit.address}</p>)`) 
          })  
        }
        console.log(content)
        
      })
      .catch(function searchFailure(err) {
        console.error(err);
      });
 });


