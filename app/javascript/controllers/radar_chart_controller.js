import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

// Connects to data-controller="radar-chart"
export default class extends Controller {
  static targets = ['currentSelection', 'myChart', 'userMap'];

  canvasContext() {
      return this.myChartTarget.getContext('2d');
  }
  
  connect() {
    this.renderChart();
  }
  
  renderChart() {

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

    // Create datasets
    const datasets = [
      {
        label: 'User',
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
      }
    ];

    new Chart(this.canvasContext(), {
        type: 'radar',
        data: {
            labels: labels,
            datasets: datasets,
        },
        options: {
          scales: {
            r: {
                angleLines: {
                    display: true
                },
                suggestedMin: -1,
                suggestedMax: 10
            }
        }
        }
    });
  }

  selectRole(event) {
    const roleData = {
      id: event.target.dataset.roleId,
      title: event.target.dataset.title,
      management_skill:  event.target.dataset.managementSkill,
      technical_skill:  event.target.dataset.technicalSkill,
      communication_skill:  event.target.dataset.communicationSkill,
      financial_skill:  event.target.dataset.financialSkill,
      analytical_skill:  event.target.dataset.analyticalSkill,
      work_ethics:  event.target.dataset.workEthics
    }

    // Get the chart instance
    const chart = this.chartInstance();

    // Find the index of the "Role Skill Maps" dataset
    const roleDatasetIndex = chart.data.datasets.findIndex(dataset => dataset.label === 'Role Skill Maps');

    const roleSkillsData = [
      roleData.management_skill,
      roleData.technical_skill,
      roleData.communication_skill,
      roleData.financial_skill,
      roleData.analytical_skill,
      roleData.work_ethics
    ];

    // If "Role Skill Maps" dataset exists, remove it
    if (roleDatasetIndex !== -1) {
      chart.data.datasets.splice(roleDatasetIndex, 1);
    }

    // Create a new "Role Skill Maps" dataset
    const roleDataset = {
        label: 'Role Skill Maps',
        data: roleSkillsData,
        backgroundColor: 'rgba(3, 138, 255, 0.2)',
        borderColor: 'rgba(3, 138, 255, 1)',
        borderWidth: 2
    };
    chart.data.datasets.push(roleDataset);

    // Update the chart
    chart.update();
    this.currentSelectionTarget.textContent = roleData.title;
  }

  chartInstance() {
    return Chart.getChart(this.myChartTarget);
  }
}
