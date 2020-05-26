class UniqueUserVote < ActiveModel::Validator
  def validate(vote)
    vote.user.votes.each do |existing_vote|
      if existing_vote.work_id == vote.work_id
        vote.errors[:create] << 'user already voted on this work'
      end
    end
  end
end