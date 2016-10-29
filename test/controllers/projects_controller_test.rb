require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { added_by: @project.added_by, contract: @project.contract, handled: @project.handled, job_type: @project.job_type, pif: @project.pif, q_sent: @project.q_sent, quote: @project.quote, reference: @project.reference, stage: @project.stage, start_date: @project.start_date, team: @project.team }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { added_by: @project.added_by, contract: @project.contract, handled: @project.handled, job_type: @project.job_type, pif: @project.pif, q_sent: @project.q_sent, quote: @project.quote, reference: @project.reference, stage: @project.stage, start_date: @project.start_date, team: @project.team }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
