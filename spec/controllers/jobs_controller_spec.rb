require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  developer_backend = {
    url: 'company.com/jobs/engineers/backend_developer',
    employer_name: 'company',
    employer_description: 'does cool things',
    job_name: 'backend engineer',
    job_description: 'builds cool things',
    year_of_experience: 1,
    education_requirement: 'college, relevant experience',
    industry: 'tech',
    base_salary: 500000,
    employment_type_id: 1
  }

  developer_intern = {
    url: 'company.com/jobs/engineers/backend_developer_intern',
    employer_name: 'company',
    employer_description: 'does cool things',
    job_name: 'backend engineer intern',
    job_description: 'assists in building cool things',
    year_of_experience: 0,
    education_requirement: 'high school, college',
    industry: 'tech',
    base_salary: 100000,
    employment_type_id: 2
  }

  describe 'POST /jobs' do
    it 'create a job object' do
      post :create, params: {
        job: developer_backend
      }
      expect(Job.count).to eq(1)
    end

    it 'responds with a job object in JSON format' do
      post :create, params: {
        job: developer_backend
      }
      expected_response = {
        job: {
          id: 1
        }
      }
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe 'GET /jobs' do
    it 'renders all jobs in JSON' do
      job_1 = Job.create(developer_backend)
      job_2 = Job.create(developer_intern)

      get :index

      expected_response = {
        jobs: [
          {
            url:                   job_1.url,
            employer_name:         job_1.employer_name,
            employer_description:  job_1.employer_description,
            job_name:              job_1.job_name,
            job_description:       job_1.job_description,
            year_of_experience:    job_1.year_of_experience,
            education_requirement: job_1.education_requirement,
            industry:              job_1.industry,
            base_salary:           job_1.base_salary,
            employment_type_id:    job_1.employment_type_id
          }, {
            url:                   job_2.url,
            employer_name:         job_2.employer_name,
            employer_description:  job_2.employer_description,
            job_name:              job_2.job_name,
            job_description:       job_2.job_description,
            year_of_experience:    job_2.year_of_experience,
            education_requirement: job_2.education_requirement,
            industry:              job_2.industry,
            base_salary:           job_2.base_salary,
            employment_type_id:    job_2.employment_type_id
          }
        ]
      }

      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe 'GET /job/id' do
    it 'renders single job by id in JSON' do
      job_1 = Job.create(developer_backend)

      get :show, params: { id: 1 }

      expected_response = {
        job: {
          url:                   job_1.url,
          employer_name:         job_1.employer_name,
          employer_description:  job_1.employer_description,
          job_name:              job_1.job_name,
          job_description:       job_1.job_description,
          year_of_experience:    job_1.year_of_experience,
          education_requirement: job_1.education_requirement,
          industry:              job_1.industry,
          base_salary:           job_1.base_salary,
          employment_type_id:    job_1.employment_type_id
        }
      }
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
