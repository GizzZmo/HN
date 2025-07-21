// harmonia_nexus/web/ts/app.ts

document.addEventListener('DOMContentLoaded', () => {
    console.log('Harmonia Nexus Frontend Loaded.');

    const echoForm = document.querySelector<HTMLFormElement>('#echo-submission form');
    const echoContentInput = document.getElementById('echo-content') as HTMLTextAreaElement;
    const contextTagsInput = document.getElementById('context-tags') as HTMLInputElement;
    const pathsContainer = document.getElementById('paths-container');

    if (echoForm && echoContentInput && contextTagsInput) {
        echoForm.addEventListener('submit', (event: Event) => {
            event.preventDefault(); // Prevent default form submission
            const content = echoContentInput.value;
            const tags = contextTagsInput.value.split(',').map(tag => tag.trim()).filter(tag => tag.length > 0);

            if (content.length > 0) {
                console.log('Submitting Echo:', { content, tags });
                // In a real application, this would send data to a backend API.
                // For now, we'll just log and clear the form.
                alert('Echo submitted! It will now be harmonized to find connections.');
                echoContentInput.value = '';
                contextTagsInput.value = '';
                // Optionally, trigger a refresh of resonance paths here
                loadResonancePaths();
            } else {
                alert('Echo content cannot be empty!');
            }
        });
    }

    function loadResonancePaths() {
        if (pathsContainer) {
            pathsContainer.innerHTML = '<p>Searching for new Resonance Paths...</p>';
            // Simulate fetching paths from a backend (which would use Haskell/Prolog)
            setTimeout(() => {
                pathsContainer.innerHTML = `
                    <div class="resonance-path-card">
                        <h3>Path ID: bridge_e001_e002</h3>
                        <p><strong>Shared Feeling:</strong> Sorrow</p>
                        <p><strong>Echo A:</strong> "The quiet despair of a lost crop." (Context: agriculture, rural)</p>
                        <p><strong>Echo B:</strong> "The empty feeling after a job layoff." (Context: urban, economic)</p>
                        <button>Explore This Path</button>
                    </div>
                    <div class="resonance-path-card">
                        <h3>Path ID: bridge_e007_e008</h3>
                        <p><strong>Shared Feeling:</strong> Injustice</p>
                        <p><strong>Echo A:</strong> "The heavy burden of discrimination." (Context: social, minority)</p>
                        <p><strong>Echo B:</strong> "The frustration with systemic corruption." (Context: political, developing_nation)</p>
                        <button>Explore This Path</button>
                    </div>
                `;
                addExploreButtonListeners();
            }, 2000); // Simulate network delay
        }
    }

    function addExploreButtonListeners() {
        document.querySelectorAll('.resonance-path-card button').forEach(button => {
            button.addEventListener('click', () => {
                const pathId = (button.previousElementSibling?.previousElementSibling as HTMLElement)?.textContent?.replace('Path ID: ', '') || 'unknown_path';
                alert(`Exploring path: ${pathId}. This would lead to a dedicated reflection interface.`);
                // In a real app, this would navigate to a detailed view or open a modal.
            });
        });
    }

    // Initial load of resonance paths
    loadResonancePaths();
});
