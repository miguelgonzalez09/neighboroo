//*= require mapbox-gl
//= require algolia/v3/algoliasearch.min
//= require rails-ujs
//= require_tree .
var client = algoliasearch('3EG2SOA15K', '024010d4d989e28aa20dd669ace79423');
var index = client.initIndex('Item');
let searchVar = document.querySelector("#query");
let queryValue = searchVar.value;

searchVar.addEventListener("input", (e) => {
    index.search(e.target.value, { hitsPerPage: 10, page: 0 })
      .then(function searchDone(content) {
        console.log(content)
      })
      .catch(function searchFailure(err) {
        console.error(err);
      });
 });

//  1. add the filter based on params to the index action
//  2. when the user clicks on the your items link 
//  3. add the param to the url with js and reload the page with that new paramr