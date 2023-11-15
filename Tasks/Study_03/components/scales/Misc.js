// Assigning scale label dimensions
var size_scale_labels = '<p style="font-size: 17px; line-height: 19px;">'
var size_scale_questions = "<p style='font-size: 22px; line-height: 24px;'>"
var style_likert = '<div style="width:1300px;"><p style="font-size: 30px; line-height: 34px;">'
var style_response_labels = '<p style="font-size: 26px; line-height: 30px;">'

// Creating labels
var YesNo = [size_scale_labels + 'Yes</p>', 
             size_scale_labels + 'No</p>']

// Assessing Regulation Examples
var Misc_Examples = {
  type: jsPsychSurveyText,
  questions: [
    {prompt: size_scale_questions + 'People may reappraise or distract themselves in different ways. <br><br> Please give a brief example of how <strong>REAPPRAISAL</strong> could have been used while watching one of the previous video clips</p>', placeholder: 'Please enter a REAPPRAISAL here.'},
    {prompt: size_scale_questions + 'Please give a brief example of how <strong>DISTRACTION</strong> could have been used while watching one of the previous video clips</p>', placeholder: 'Please enter a DISTRACTION here.'}
  ],
  data: {task: 'Misc_Examples'},
  required: true,
};

// Creating a question item to measure familiarity with any videos
var Misc_Familiar_Any = {
    type: jsPsychHtmlButtonResponse,
    stimulus: size_scale_questions + 'Were you familiar with any of the videos that you had watched?.</p>',
    choices: YesNo,
    data: {task: 'Misc_Familiar_Any'},
    required: true,
};

// Horror Enjoyment Labels
var labels_horror = [
  style_response_labels + 'Not at all<br>Enjoy</p>', style_response_labels + 'Slightly<br>Enjoy</p>', style_response_labels + 'Somewhat<br>Enjoy</p>', style_response_labels + 'Moderately<br>Enjoy</p>', style_response_labels + 'Considerably<br>Enjoy</p>', style_response_labels + 'Very much<br>Enjoy</p>', style_response_labels + 'Extremely<br>Enjoy</p>'
]

// Assessing horror movie enjoyment
var Misc_Horror_Enjoy = {
    type: jsPsychSurveyLikert,
    questions:[{prompt: style_likert + 'How much do you enjoy watching horror movies?</p>', name: 'Horror_Enjoy', labels: labels_horror },],
    data: {task: 'Misc_Horror_Enjoy'},
};

// Attention Check Labels
var labels_attention = [
  style_response_labels + 'Not at all</p>', style_response_labels + 'Slightly</p>', style_response_labels + 'Somewhat</p>', style_response_labels + 'Moderately</p>', style_response_labels + 'Considerably</p>', style_response_labels + 'Very much</p>', style_response_labels + 'Extremely</p>'
]

// Attention Check
var Misc_Attention_Check = {
  type: jsPsychSurveyLikert,
  questions:[{prompt: style_likert + 'This is an attention check: Select "Considerably" to pass it?</p>', name: 'Attention_Check', labels: labels_attention},],
  data: {task: 'Misc_Attention_Check'},
};

// Assessing audio medium (under the assumption that this might relate to immersion, which might relate to intensity)
var Misc_Audio = {
  type: jsPsychHtmlButtonResponse,
  stimulus: size_scale_questions + 'How did you hear audio during this experiment?.</p>',
  choices: ['Through Headphones or Earbuds (i.e., played in-ear)',
  'Through Speakers (i.e., played outloud)',
  'I did not hear audio during this experiment'],
  data: {task: 'Misc_Audio_Method'},
  required: true,
};

// Assessing difficulties with the task
var Misc_Difficulties = {
    type: jsPsychSurveyText,
    questions: [
      {prompt: size_scale_questions + 'Did you experience any difficulties or confusion while completing this study?</p>', placeholder: 'If so, please explain. If not, leave blank.'}
    ],
    data: {task: 'Misc_Difficulties'},
  };

// Assessing whether the participant has any lingering questions
var Misc_Questions = {
    type: jsPsychSurveyText,
    questions: [
      {prompt: size_scale_questions + 'Did you have any questions about your experience today?</p>', placeholder: 'If so, please explain. If not, leave blank.'}
    ],
    data: {task: 'Misc_Questions'},
};