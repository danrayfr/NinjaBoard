def generate_courses
  courses = course_collection
  user = User.find_by(email: 'ninjaboard-admin@gmail.com')

  courses.each do |course|
      Course.create(
        title: course[:title],
        description: Faker::Lorem.sentence,
        author: course[:author],
        category: course[:category],
        impact: impacts.sample,
        user: user
      )
  end

  puts('Done creating courses data')
end

def update_courses
  puts('Updating courses url')
  Course.all.each do |course|
    course.update(url: "https://ninjaboard.com/course/#{course.slug}")
  end
end

def course_collection
  [
    { title: 'Tell NELi roadshow', category: 'work_ethics', author: 'John Dave Cabiling' },
    { title: 'Tell NELi (Ninja Ethics Line)', category: 'work_ethics', author: 'John Dave Cabiling' },
    { title: 'Security Awareness Fundamentals', category: 'technical', author: 'John Dave Cabiling' },
    { title: 'Occupational Safety and Health', category: 'work_ethics', author: 'Robby Manoy' },
    { title: 'The Ninja MasterClass Episode 1', category: 'management', author: 'John Dave Cabiling' },
    { title: 'Phrasal Verbs Part 1', category: 'communication', author: 'John Dave Cabiling' },
    { title: 'Parts of Speech', category: 'communication', author: 'Robby Manoy' },
    { title: 'Verb Tenses', category: 'communication', author: 'John Dave Cabiling' },
    { title: 'Positive Scripting', category: 'communication', author: 'Bernadette Guinto' },
    { title: 'Business Operation Plan', category: 'management', author: 'Timothy Kwok' },
    { title: 'Bard AI Prompt Engineering Guide', category: 'technical', author: 'Timothy Kwok' },
    { title: 'Windows Networking', category: 'technical', author: 'Timothy Kwok' },
    { title: 'Tech Solutions Call Flow', category: 'technical', author: 'Timothy Kwok' },
    { title: 'Mac Computer Training', category: 'technical', author: 'Timothy Kwok' },
    { title: 'Handling Common Breakfix Issues', category: 'analytical', author: 'Timothy Kwok' },
    { title: 'The Art of Control', category: 'analytical', author: 'Timothy Kwok' },
    { title: 'Troubleshooting Methodology', category: 'analytical', author: 'Timothy Kwok' },
    { title: '4 Mental Exercises to Improve Your Time Management', category: 'management', author: 'Bernadette Guinto' },
    { title: '3 Leadership skills you should never compromise', category: 'management', author: 'Robby Manoy' },
    { title: 'Account Assessment 1', category: 'financial', author: 'Shirley Lunar' }
  ]
end

def impacts
  [
    0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
    1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
  ]
end
