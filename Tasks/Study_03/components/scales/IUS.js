// Assigning scale label dimensions
var size_scale_labels = '<p style="font-size: 17px; line-height: 19px;">'
var size_scale_questions = "<p style='font-size: 22px; line-height: 24px;'>"

// Defining our scale options
var IUS_scale = [
    size_scale_labels + 'Not at all<br>characteristic of me</p>',
    size_scale_labels + 'A little<br>characteristic of me</p>',
    size_scale_labels + 'Somewhat<br>characteristic of me</p>',
    size_scale_labels + 'Very<br>characteristic of me</p>',
    size_scale_labels + 'Entirely<br>characteristic of me</p>',
  ];

// Creating a question item
  var IUS = {
    type: jsPsychSurveyLikert,
    preamble: [
               '<p style="font-size: 26px; width: 1200px; line-height: 30px;"> <strong>Instructions:</strong> Please identify how much you agree with each item.</p>'
              ], 
    questions: [
      {prompt: size_scale_questions + "Unforeseen events upset me greatly.</p>", name: 'IUS-SF_01', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "It frustrates me not having all the information I need.</p>", name: 'IUS-SF_02', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "Uncertainty keeps me from living a full life.</p>", name: 'IUS-SF_03', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "One should always look ahead so as to avoid surprises.</p>", name: 'IUS-SF_04', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "A small unforeseen event can spoil everything, even with the best of planning.</p>", name: 'IUS-SF_05', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "When it's time to act, uncertainty paralyses me.</p>", name: 'IUS-SF_06', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "When I am uncertain I can't function very well.</p>", name: 'IUS-SF_07', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "I always want to know what the future has in store for me.</p>", name: 'IUS-SF_08', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "I can't stand being taken by surprise.</p>", name: 'IUS-SF_09', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "The smallest doubt can stop me from acting.</p>", name: 'IUS-SF_10', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "I should be able to organize everything in advance.</p>", name: 'IUS-SF_11', labels: IUS_scale, required: true},
      {prompt: size_scale_questions + "I must get away from all uncertain situations.</p>", name: 'IUS-SF_12', labels: IUS_scale, required: true},
    ],
    randomize_question_order: false,
    data: {task: 'Scale'},
  };