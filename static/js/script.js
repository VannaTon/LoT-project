function updateConnectionStatus() {
    fetch('/status')
        .then(response => response.json())
        .then(data => {
            const indicator = document.getElementById('status-indicator');
            const connectionText = document.getElementById('connection-text');

            if (data.connected) {
                indicator.classList.add('connected');
                indicator.classList.remove('disconnected');
                connectionText.textContent = 'Connected to Arduino';
            } else {
                indicator.classList.add('disconnected');
                indicator.classList.remove('connected');
                connectionText.textContent = 'Disconnected from Arduino';
            }

            for (let i = 1; i <= 3; i++) {
                const ledStatus = document.getElementById(`led${i}-status`);
                if (ledStatus) {
                    ledStatus.textContent = data.led_states[i] ? 'ON' : 'OFF';
                }
            }
        })
        .catch(error => {
            console.error('Error checking status:', error);
        });
}

updateConnectionStatus();
setInterval(updateConnectionStatus, 5000);
