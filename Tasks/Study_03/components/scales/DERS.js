// Assigning scale label dimensions
var size_scale_labels = '<p style="font-size: 17px; line-height: 19px;">'
var size_scale_questions = "<p style='font-size: 22px; line-height: 24px;'>"

// Defining our scale options
var DERS_scale = [
    size_scale_labels + 'Almost never<br><i>(00 - 10%)</i></p>', 
    size_scale_labels + 'Sometimes<br><i>(11 - 35%)</i></p>',
    size_scale_labels + 'About half the time<br><i>(36 - 65%)</i></p>',
    size_scale_labels + 'Most of the time<br><i>(66 - 90%)</i></p>',
    size_scale_labels + 'Almost always<br><i>(91 - 100%)</i></p>',
  ];

// Creating a question item
var DERS = {
  type: jsPsychSurveyLikert,
  preamble: [
              '<p style="font-size: 26px; width: 1200px; line-height: 30px;"><strong>Instructions:</strong> Please indicate how often the following statements apply to you by selecting the appropriate response on the provided scale.</p>'
            ], 
  questions: [
    {prompt: size_scale_questions + "I am clear about my feelings.</p>", name: 'DERS_01', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I pay attention to how I feel.</p>", name: 'DERS_02', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I experience my emotions as overwhelming and out of control.</p>", name: 'DERS_03', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I have no idea how I am feeling.</p>", name: 'DERS_04', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I have difficulty making sense out of my feelings.</p>", name: 'DERS_05', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I am attentive to my feelings.</p>", name: 'DERS_06', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I know exactly how I am feeling.</p>", name: 'DERS_07', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I care about what I am feeling.</p>", name: 'DERS_08', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "I am confused about how I feel.</p>", name: 'DERS_09', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I acknowledge my emotions.</p>", name: 'DERS_10', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I become angry with myself for feeling that way.</p>", name: 'DERS_11', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I become embarrassed for feeling that way.</p>", name: 'DERS_12', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I have difficulty getting work done.</p>", name: 'DERS_13', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I become out of control.</p>", name: 'DERS_14', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I believe that I will remain that way for a long time.</p>", name: 'DERS_15', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I believe that I will end up feeling very depressed.</p>", name: 'DERS_16', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I believe that my feelings are valid and important.</p>", name: 'DERS_17', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I have difficulty focusing on other things.</p>", name: 'DERS_18', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I feel out of control.</p>", name: 'DERS_19', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I can still get things done.</p>", name: 'DERS_20', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I feel ashamed at myself for feeling that way.</p>", name: 'DERS_21', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I know that I can find a way to eventually feel better.</p>", name: 'DERS_22', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I feel like I am weak.</p>", name: 'DERS_23', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I feel like I can remain in control of my behaviors.</p>", name: 'DERS_24', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I feel guilty for feeling that way.</p>", name: 'DERS_25', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I have difficulty concentrating.</p>", name: 'DERS_26', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I have difficulty controlling my behaviors.</p>", name: 'DERS_27', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I believe there is nothing I can do to make myself feel better.</p>", name: 'DERS_28', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I become irritated at myself for feeling that way.</p>", name: 'DERS_29', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I start to feel very bad about myself.</p>", name: 'DERS_30', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I believe that wallowing in it is all I can do.</p>", name: 'DERS_31', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I lose control over my behavior.</p>", name: 'DERS_32', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I have difficulty thinking about anything else.</p>", name: 'DERS_33', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, I take time to figure out what I'm really feeling.</p>", name: 'DERS_34', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, it takes me a long time to feel better.</p>", name: 'DERS_35', labels: DERS_scale, required: true},
    {prompt: size_scale_questions + "When I'm upset, my emotions feel overwhelming.</p>", name: 'DERS_36', labels: DERS_scale, required: true},
  ],
  randomize_question_order: false,
  data: {task: 'Scale'},
};