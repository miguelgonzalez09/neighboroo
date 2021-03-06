import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

initMapbox();

// test comment




const sidenavOpen = document.getElementById("sidenavOpen");

if (sidenavOpen) {
  sidenavOpen.addEventListener("click", function(){
    openNav();
  })
}

function openNav() {
  document.getElementById("sidenav").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

const sidenavClose = document.getElementById("sidenavClose");

if (sidenavClose) {
  sidenavClose.addEventListener("click", function(){
    closeNav();
  })
}

function closeNav() {
  document.getElementById("sidenav").style.width = "0";
  document.getElementById("main").style.marginLeft = "5vw";
}


var client = algoliasearch('3EG2SOA15K', '024010d4d989e28aa20dd669ace79423');
var index = client.initIndex('Item');
var searchVar = document.querySelector("#query");
var results = document.getElementById('results')
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
            results.insertAdjacentHTML('beforeEnd', `<p>${hit.name}</p><p>${hit.address}</p><p>${hit.description}</p>)`)
          })
        }
        console.log(content)

      })
      .catch(function searchFailure(err) {
        console.error(err);
      });
 });
