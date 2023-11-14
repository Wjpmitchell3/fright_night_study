// Assigning scale label dimensions
var size_scale_labels = '<p style="font-size: 17px; line-height: 19px;">'
var size_scale_questions = "<p style='font-size: 22px; line-height: 24px;'>"

// Defining our scale options
var ERQ_scale = [
  size_scale_labels + 'Strongly<br>Disagree</p>', 
  size_scale_labels + 'Disagree</p>', 
  size_scale_labels + 'Somewhat<br>Disagree</p>',
  size_scale_labels + 'Neither Agree<br>or Disagree</p>', 
  size_scale_labels + 'Somewhat<br>Agree</p>',
  size_scale_labels + 'Agree</p>', 
  size_scale_labels + 'Strongly<br>Agree</p>'
];

// Creating a question item
var ERQ = {
  type: jsPsychSurveyLikert,
  preamble: [
             '<p style="text-align: justify; font-size: 26px; width: 1200px; line-height: 30px;"><strong>Instructions:</strong> We would like to ask you some questions about your emotional life, in particular, how you control (that is, regulate and manage) your emotions. The questions below involve two distinct aspects of your emotional life. One is your <i>emotional experience</i>, or what you feel like inside. The other is your <i>emotional expression</i>, or how you show your emotions in the way you talk, gesture, or behave. Although some of the following questions may seem similar to one another, they differ in important ways. <br><br> Using the scale below, indicate your agreement with each item by selecting the appropriate statement beneath that item. Please be open and honest in your responding.</p>'
            ], 
  questions: [
    {prompt: size_scale_questions + "When I want to feel more positive emotion (such as joy or amusement), I change what I'm thinking about.</p>", name: 'ERQ_01', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "I keep my emotions to myself.</p>", name: 'ERQ_02', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I want to feel less <i>negative</i> emotion (such as sadness or anger), I <i>change what I'm thinking about</i>.</p>", name: 'ERQ_03', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I am feeling <i>positive</i> emotions, I am careful <i>not to express them</i>.</p>", name: 'ERQ_04', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I'm faced with a stressful situation, I make myself <i>think about it</i> in a way that helps me stay calm.</p>", name: 'ERQ_05', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "I control my emotions by <i>not expressing them</i>.</p>", name: 'ERQ_06', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I want to feel more <i>positive</i> emotion, I <i>change the way I'm thinking</i> about the situation.</p>", name: 'ERQ_07', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "I control my emotions by <i>changing the way I think</i> about the situation I'm in.</p>", name: 'ERQ_08', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I am feeling <i>negative</i> emotions, I make sure <i>not to express them</i>.</p>", name: 'ERQ_09', labels: ERQ_scale, required: true},
    {prompt: size_scale_questions + "When I want to feel less <i>negative</i> emotion, I <i>change the way I'm thinking</i> about the situation.</p>", name: 'ERQ_10', labels: ERQ_scale, required: true},
  ],
  randomize_question_order: false,
  data: {task: 'Scale'},
};