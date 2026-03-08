console.log("NUI LOADED");

const panel = document.getElementById('panel');

document.getElementById("closeBtn").style.display = "none";

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'show') {
        panel.classList.remove("hidden");
        panel.classList.remove("hideAnim");
        panel.classList.add("showAnim");
    }

    else if (data.action === 'hide') {
        panel.classList.remove("showAnim");
        panel.classList.add("hideAnim");

        setTimeout(() => {
            panel.classList.add("hidden");
        }, 350);
    }

    else if (data.action === 'update') {
        document.getElementById('cash').innerText = data.cash;
        document.getElementById('bank').innerText = data.bank;
        document.getElementById('id').innerText = data.id;
        document.getElementById('job').innerText = data.job;
        document.getElementById('rank').innerText = data.rank; 
    }
});

document.addEventListener("DOMContentLoaded", () => {
    const closeBtn = document.getElementById('closeBtn');
    if (!closeBtn) return;

    closeBtn.addEventListener('click', () => {
        fetch(`https://${GetParentResourceName()}/close`, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: "{}"
        });
    });
});
fetch(`https://${GetParentResourceName()}/nuiReady`, { method: "POST" });
