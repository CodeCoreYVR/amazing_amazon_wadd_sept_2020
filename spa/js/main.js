console.log('connected')
const BASE_URL = `http://localhost:3000/api/v1`;
const Products= {
index() {
return fetch(`${BASE_URL}/products`,{
headers: {
'Cache-Control': 'no-cache'
}})
.then(res => {
return res.json();
})
},

show(id) {
return fetch(`${BASE_URL}/products/${id}`)
.then(res => res.json())
.catch(console.error)
},
create(params) {
return fetch(`${BASE_URL}/products`, {
method: 'POST',
credentials: 'include',
headers: {
'Content-Type': 'application/json'
},
body: JSON.stringify(params)
}).then(res => res.json())
.catch(console.error)
}

}
const Session={
create(params){
return fetch(`${BASE_URL}/session`,{
method:"POST",
credentials:"include",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify(params)
}).then(res => res.json());
}
}
Session.create({email:'js@winterfell.gov', password:'supersecret'})

function loadProducts() {
Products.index().then(products => {
const productContainer = document.querySelector('ul.product-list');
productContainer.innerHTML =products.map(product => {
return `
<li>
<a class='product-link' data-id=${product.id} href=''>
${product.id} - ${product.title}
</a>
</li>
`
}).join('')
})
}
loadProducts();
const productContainer = document.querySelector('ul.product-list');
productContainer.addEventListener('click', (event) => {
event.preventDefault();
const productElement = event.target
if (productElement.matches('a.product-link')) {
renderProductShow(productElement.dataset.id)
}
})
function renderProductShow(id) {
Products.show(id).then(product => {
const showPage = document.querySelector('.page#product-show')
const showPageHTML = `
<h2>${product.title}</h2>
<p>${product.description}</p>
`
showPage.innerHTML = showPageHTML;
navigateTo('product-show')
})
}



