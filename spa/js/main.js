console.log("connected");
const BASE_URL = `http://localhost:3003/api/v1`;
const Products = {
  index() {
    return fetch(`${BASE_URL}/products`, {
      headers: {
        "Cache-Control": "no-cache",
      },
    }).then((res) => {
      return res.json();
    });
  },

  show(id) {
    return fetch(`${BASE_URL}/products/${id}`)
      .then((res) => res.json())
      .catch(console.error);
  },
  create(params) {
    return fetch(`${BASE_URL}/products`, {
      method: "POST",
      credentials: "include",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(params),
    })
      .then((res) => res.json())
      .catch(console.error);
  },
  delete(id) {
    return fetch(`${URL}/products/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json', 
      },
      credentials: 'include'
    })
  }
};
const Session = {
  create(params) {
    return fetch(`${BASE_URL}/session`, {
      method: "POST",
      credentials: "include",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(params),
    }).then((res) => res.json());
  },
};
Session.create({ email: "js@winterfell.gov", password: "supersecret" });

function loadProducts() {
  Products.index().then((products) => {
    const productContainer = document.querySelector("ul.product-list");
    productContainer.innerHTML = products
      .map((product) => {
        return `
<li>
<a class='product-link' data-id=${product.id} href=''>
${product.id} - ${product.title}
</a> - 
<a href="#" 
  onclick="Products.delete(${product.id})
  .then(loadProducts)">Delete
</a>
</a>
</li>
`;
      })
      .join("");
  });
}


loadProducts();
const productContainer = document.querySelector("ul.product-list");
productContainer.addEventListener("click", (event) => {
  event.preventDefault();
  const productElement = event.target;
  if (productElement.matches("a.product-link")) {
    renderProductShow(productElement.dataset.id);
  }
});
function renderProductShow(id) {
  Products.show(id).then((product) => {
    const showPage = document.querySelector(".page#product-show");
    const showPageHTML = `
<h2>${product.title}</h2>
<p>${product.description}</p>
`;
    showPage.innerHTML = showPageHTML;
    navigateTo("product-show");
  });
}

function navigateTo(pageId) {
    document.querySelectorAll('.page').forEach(node => {
        node.classList.remove('active')
    })
    document.querySelector(`.page#${pageId}`).classList.add('active');
}
const navbar = document.querySelector('nav.navbar')
navbar.addEventListener('click', (event) => {
    event.preventDefault();
    const node = event.target;
    const page = node.dataset.id;
    if (page){
        console.log(page);
        navigateTo(page)
    }
}) 
const newProductForm=document.querySelector('#new-product-form');
newProductForm.addEventListener('submit',(event)=>{
    event.preventDefault();
    const form=event.currentTarget
    console.log(form);
    const fd=new FormData(form)
    const newProductParams={
        title:fd.get('title'),
        description:fd.get('description'),
        price:fd.get('price')
    }
    console.log(newProductParams);
    Products.create(newProductParams).then(data=>{
        console.log(data)
        renderProductShow(data.id)
    })
    .catch(err=>console.log(err))
})
  createForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const form = event.currentTarget
    const formData = new FormData(form)
    const object = {
      title: formData.get('title'),
      description: formData.get('description'),
      price: formData.get('price'),
      sale_price: formData.get('sale-price')
    }
    Product.create(object).then(data => {
      console.log(data)
    })
  })