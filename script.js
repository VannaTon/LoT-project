
// Update connection status every 5 seconds
function updateConnectionStatus() {
    fetch('/status')
        .then(response => response.json())
        .then(data => {
            const indicator = document.getElementById('status-indicator');
            const connectionText = document.getElementById('connection-text');

            if (data.connected) {
                indicator.classList.remove('disconnected');
                indicator.classList.add('connected');
                connectionText.textContent = 'Connected to Arduino';
            } else {
                indicator.classList.remove('connected');
                indicator.classList.add('disconnected');
                connectionText.textContent = 'Disconnected from Arduino';
            }

            // Update LED states
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

// Initial update
updateConnectionStatus();

// Update every 5 seconds
setInterval(updateConnectionStatus, 5000);


