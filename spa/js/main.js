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
    Session.create({email:'js@winterfell.gov', password:'supersecret'}).then(console.log)

function loadProducts() {
    Products.index().then(products => {
        const productContainer = document.querySelector('ul.product-list');
        productContainer.innerHTML =products.map(product => {
            console.log(product)
            return `
    <li>
        <a class='product-link' data-id=${product.id} href=''>
            ${product.id} - ${product.title} - ${product.price}
        </a>
    </li>
    `
        }).join('')
    })

}
loadProducts();
