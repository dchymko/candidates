# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

# More methods will go below

def getIdFromString(option)
  str = option.split(" ")
  str[1].to_i
end

def find(id)  
  #binding.pry
  @candidates.each { |candidate| 
    if candidate[:id] == id 
      return candidate
    end

  }
  return "candidate #{id} not found"
end

def experienced?(candidate, experience=2)
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
  experienced?(candidate, years) && 
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

