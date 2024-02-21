import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

// Connects to data-controller="radar-chart"
export default class extends Controller {
  static targets = ['myChart', 'userMap'];

    canvasContext() {
        return this.myChartTarget.getContext('2d');
    }

    connect() {
      const labels = ['Management', 'Technical', 'Communication', 'Financial', 'Analytical', 'Work Ethics'];

     // Extracting values from data attributes
     const data = {
       management_skill: parseFloat(this.userMapTarget.dataset.managementSkill),
       technical_skill: parseFloat(this.userMapTarget.dataset.technicalSkill),
       communication_skill: parseFloat(this.userMapTarget.dataset.communicationSkill),
       financial_skill: parseFloat(this.userMapTarget.dataset.financialSkill),
       analytical_skill: parseFloat(this.userMapTarget.dataset.analyticalSkill),
       work_ethics: parseFloat(this.userMapTarget.dataset.workEthics)
     };

     console.log('Data: ', data)

      // Create datasets
      const datasets = [
        {
          label: 'User Skill Maps',
          data: labels.map(label => {
            if (label === "Work Ethics") {
              return data.work_ethics;
            } else {
              return data[`${label.toLowerCase().replace(' ', '_')}_skill`];
            }
          }),
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 2
        },
        {
          label: 'Role Skill Maps',
          data: [25, 25, 50, 30, 50, 100],
          backgroundColor: 'rgba(3, 138, 255, 0.2)',
          borderColor: 'rgba(3, 138, 255, 1)',
          borderWidth: 2
        }
      ];

        new Chart(this.canvasContext(), {
            type: 'radar',
            data: {
                labels: labels,
                datasets: datasets,
            },
            options: {
            }
        });
    }
}
