class PollSerializer
	def self.count_per_month poll
		replies = poll.replies.group_by { |reply| reply.created_at.begining_of_month }
		
		data = replies.map { |key, values| values.length }
		{
			data: data, 
			x_axis: {
				legend: "Polls per month"
				series: replies.key.map { |date| date.strftime("%b %Y") }
			},
			y_axis: {
				legend: "No. polls", 
				scale: [0, data.max + 1]
			}
		}
	end

	def self.answers_per_question question
		amwers_per_question = question.answers.group_by(&:possible_answer)
		data = answers_per_question.map { |possible_answer, answer| answers.length }
		series = answers_per_question.map { |possible_answer, answer| possible_answer.title }

		{
			data: data,
			title: question.title,  
			x_axis: {
				legend: "Polls per month"
				series: series 
			},
			y_axis: {
				legend: "No. polls", 
				scale: [0, (data.max or 0) + 1]
			}
		}
	end
end