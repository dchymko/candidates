# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

# More methods will go below

def getIdFromString(option)
  str = option.split(" ")
  str[1].to_i
end

def find(id)  
  raise '@candidates MUST be an array' if @candidates.nil?
  @candidates.each { |candidate| 
    if candidate[:id] == id 
      return candidate
    end
  }
  return "Candidate #{id} not found"
end

class InvalidCandidateError < StandardError
  begin
  #puts "InvalidCandidateError"
  end
end

def experienced?(candidate, experience=2) 
  unless candidate.has_key?(:years_of_experience)
    raise InvalidCandidateError, 'Candidate data missing the :years_of_experience key!'
  end
  candidate[:years_of_experience] >= experience
end

def valid_github_points?(candidate, points)
  candidate[:github_points] >= points
end

def has_languages?(candidate, language_array)
  lang_count = 0
  language_array.each { |lang| 
    if candidate[:languages].include?(lang)
      return true
    end    
  }
  return false

end

def recently_applied?(candidate, days)
  candidate[:date_applied] > days.days.ago.to_date
end

def isNoob?(candidate, age)
  candidate[:age] > age
end

def isValidCandidate?(candidate, years, git_points, languages, days_applied, age)
  begin
    experienced = experienced?(candidate, years) 
  rescue InvalidCandidateError => ex
    puts "Can't determine if one of the candidates has enough experience"
    puts "Reason: #{ex.message}"
  end 
  experienced && 
  valid_github_points?(candidate, git_points) && 
  has_languages?(candidate, languages) &&
  recently_applied?(candidate, days_applied) &&
  isNoob?(candidate, age)
end

def qualified_candidates
  validCandidates = []
  @candidates.select { |candy| 
    if isValidCandidate?(candy, 2, 100, ['Ruby', 'Python'], 15, 17)
      validCandidates << candy
    end
  }
  #byebug
  s = validCandidates.join(" ")
end

def ordered_by_qualifications(candies)
  orderedCandidates = candies.sort_by { |hash| [ -hash[:years_of_experience], -hash[:github_points] ] }
  #byebug
  s = orderedCandidates.join(" ")
end

