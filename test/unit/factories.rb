FactoryGirl.define do
	factory :reply do
	end

	factory :answer do
	end

	factory :possible_answer do
	end

	factory :question do
		title "Question #1"
		kind "choice"

		factory :full_question do
			ignore do
				answer_count 5
				possible_answer_count 5
			end

			after(:create) do |question, evaluator|
				create_list :answer, 
					evaluator.answer_count, 
					question: question,
					possible_answer_id: 1

				create_list :possible_answer, 
					evaluator.possible_answer_count, 
					question: question
			end
		end
	end

	factory :poll do
		title "Factory Poll"

		factory :full_poll do
			ignore do
				replies_count 5
				questions_count 5
			end
			after(:create) do |poll, evaluator|
				create_list :full_question, evaluator.questions_count, poll: poll
				create_list :reply, evaluator.replies_count, poll: poll
			end
		end
	end	
end
	