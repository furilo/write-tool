# frozen_string_literal: true

# Admins
user = User.create(
  name: "prompter user",
  email: "prompter@example.org",
  password: "prompter",
  password_confirmation: "prompter",
  terms_of_service: true
)

puts "- Created user: #{user.email}"

# Grant system admin role
# jumpstart.grant_system_admin!(user)

# Prompt projects

prompt_project = PromptProject.create title: "Prompter - Question suggestions", description: "A prompt to help develop and improve questions for the prompter project.", user: user
puts "- Created prompt project: #{prompt_project.title}"

last_version = prompt_project.versions.last
puts "- Created version #{last_version.version} for prompt project: #{prompt_project.title}"

variables_set = VariablesSet.create user: user,
  name: "Turismo en España",
  variables: {
    what: "experto en turismo",
    few_shots: [
      "What is the best way to learn Spanish? Madrid",
      "Where is the best place to eat paella? Valencia"
    ],
    question: "Where can I visit the Acueducto?"
  }
puts "- Created variables set: #{variables_set.id}: #{variables_set.variables}"

last_version.variables_sets_ids << variables_set.id
last_version.save

ai_unit1 = AiUnit.create prompt_project_version: last_version,
  llm_params: {
    service: "openai",
    action: "chat/completions",
    model: "gpt-3.5-turbo",
    model_params: {temperature: 0.2, max_tokens: 100, top_p: 1, frequency_penalty: 0.5, presence_penalty: 0.5}
  },
  prompt: [
    {
      role: "system", content: "Eres un {{what}}"
    },
    {
      role: "user", content: "Te voy a preguntar sobre turismo en España. Te voy a dar unos ejemplos: \n {{few_shots}}\n"
    },
    {
      role: "user", content: "Responde a la siguiente pregunta: {{question}}\n"
    }
  ]

user_credentials = UserCredentials.new nil
executor = Executor.new prompt: ai_unit1.prompt, user_credentials: user_credentials, llm_params: ai_unit1.llm_params, variables: variables_set.variables
response = executor.run
ai_execution = last_version.ai_executions.create ai_unit: ai_unit1, variables_set: variables_set, response: response.raw_response
puts "- Created ai execution: #{ai_execution.id} with response: #{ai_execution.response}"

ai_unit2 = AiUnit.create prompt_project_version: last_version,
  llm_params: {
    service: "openai",
    action: "chat/completions",
    model: "gpt-3.5-turbo",
    model_params: {temperature: 0.2, max_tokens: 100, top_p: 1, frequency_penalty: 0.5, presence_penalty: 0.5}
  },
  prompt: [
    {
      role: "system", content: "Eres un {{what}}"
    },
    {
      role: "user", content: "You are a Spanish tourist guide. You are asked this kind of questions: \n {{few_shots}}\n"
    },
    {
      role: "user", content: "Answer the following question: {{question}}\n"
    }
  ]

user_credentials = UserCredentials.new nil
executor = Executor.new prompt: ai_unit2.prompt, user_credentials: user_credentials, llm_params: ai_unit2.llm_params, variables: variables_set.variables
response = executor.run
ai_execution = last_version.ai_executions.create ai_unit: ai_unit2, variables_set: variables_set, response: response.raw_response
puts "- Created ai execution: #{ai_execution.id} with response: #{ai_execution.response}"
