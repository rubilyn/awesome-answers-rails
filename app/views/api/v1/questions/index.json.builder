# this generates a JSON array as the main element
json.array! @questions do |question|
  json.id question.id
  json.title question.title

  json.title question.title
  json.created_at question.created_at.strftime('%Y-%B-%d') #or ('%Y, %B %d')
  json.url api_v1_question_path()
end
