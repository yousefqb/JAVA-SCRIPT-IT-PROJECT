
function addTask() {
    const input = document.getElementById('taskInput');
    const list = document.getElementById('taskList');
    
    if (input.value.trim() !== "") {
        const li = document.createElement('li');
        li.innerHTML = `
            <span>${input.value}</span>
            <button onclick="this.parentElement.remove()" style="background:red; padding:2px 8px;">X</button>
        `;
        list.appendChild(li);
        input.value = ""; 
    }
}

function copyColor(hex) {
    navigator.clipboard.writeText(hex);
    alert("Color copied: " + hex);
}

window.onload = function() {
    const modal = document.getElementById('autoModal');
    if (modal) {
        modal.style.display = 'flex';
    }
}

function closeModal() {
    document.getElementById('autoModal').style.display = 'none';
}