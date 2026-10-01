document.addEventListener('DOMContentLoaded', function() {
    const inventory = document.getElementById('inventory');
    const closeButton = document.getElementById('close-button');
    const inventoryItems = document.querySelector('.inventory-items');
    const inventoryDetails = document.querySelector('.inventory-details');
    
    closeButton.addEventListener('click', function() {
        fetch('https://moderninventory/closeInventory', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(resp => {
            inventory.style.display = 'none';
        });
    });
    
    window.addEventListener('message', function(event) {
        const data = event.data;
        if (data.action === 'openInventory') {
            inventory.style.display = 'block';
            renderInventory(data.inventory);
        }
    });
    
    function renderInventory(inventory) {
        inventoryItems.innerHTML = '';
        inventory.forEach(item => {
            const itemElement = document.createElement('div');
            itemElement.className = 'inventory-item';
            itemElement.innerHTML = `<img src="${item.image}" alt="${item.label}"><span>${item.label}</span><span>${item.count}</span>`;
            itemElement.addEventListener('click', function() {
                renderItemDetails(item);
            });
            inventoryItems.appendChild(itemElement);
        });
    }
    
    function renderItemDetails(item) {
        inventoryDetails.innerHTML = '';
        const detailsElement = document.createElement('div');
        detailsElement.className = 'item-details';
        detailsElement.innerHTML = `<h2>${item.label}</h2><p>${item.description}</p><button id="use-button">Use</button><button id="drop-button">Drop</button>`;
        
        const useButton = detailsElement.querySelector('#use-button');
        useButton.addEventListener('click', function() {
            fetch('https://moderninventory/useItem', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({ item: item.name })
            }).then(resp => resp.json()).then(resp => {
                console.log('Item used');
            });
        });
        
        const dropButton = detailsElement.querySelector('#drop-button');
        dropButton.addEventListener('click', function() {
            const count = prompt('How many do you want to drop?', '1');
            if (count) {
                fetch('https://moderninventory/dropItem', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8'
                    },
                    body: JSON.stringify({ item: item.name, count: parseInt(count) })
                }).then(resp => resp.json()).then(resp => {
                    console.log('Item dropped');
                });
            }
        });
        
        inventoryDetails.appendChild(detailsElement);
    }
});