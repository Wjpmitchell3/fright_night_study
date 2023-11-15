// Formatting our labels and instructions
var style_response_labels = '<p style="font-size: 26px; line-height: 30px;">' 
var style_strat_labels = '<font size="+7"><p>'
var style_instr = '<p style="font-size: 36px; width: 1200px; line-height: 40px;">'
var style_instr_nowidth = '<p style="font-size: 36px; line-height: 40px;">'
var style_question = '<div style="width:1000px;"><p style="font-size: 30px; line-height: 34px;">'
var style_likert = '<div style="width:1300px;"><p style="font-size: 30px; line-height: 34px;">'
var style_strat_descs = '<br><br><div class="container">'

// Consent labels
var labels_Consent = [style_strat_labels + 'I consent to<br>participate in this study</p></font>', style_strat_labels + 'I do not consent to<br>participate in this study</p></font>']

// ViewVideo Labels
var labels_ViewVideos = [style_response_labels + 'View</p></font>', style_response_labels + 'Skip</p></font>']

// Error messages
var error_Laptop = [
    style_instr + 'You must use a desktop/laptop computer to participate in this experiment.</p>'
]
var error_Browser = [
    style_instr + 'You must use Chrome, Firefox, or Safari as your browser to complete this experiment.</p>'
]

// Creating instructions for other miscellaneous objects
var instr_Warning = [
    style_instr + 'During this experiment, you will watch a set of movie clips. You will also answer questions about your experience after watching each clip. <br><br><br> <strong><i>Please be aware</i> that these movie clips are sourced from horror films and may contain mature language, gore, violence, mutilation, and/or harm to oneself or others.</strong> <br><br><br> If you are not comfortable with continuing, please exit this experiment now and "return" your participation on Prolific. <br><br><br><br> Otherwise, please press the <strong>SPACE BAR</strong> to continue</p>'
]
var instr_ViewVideosWarning = [
    style_instr + '<strong> THIS OPTION IS ONLY AVAILABLE DURING PROJECT DEVELOPMENT</strong>:<br><br>If you are uncomfortable watching the videos, I have added an option to skip them. A message will appear before the video plays and you can click "Skip Video" to do so. You would have to answer questions as if you did see them, though.<br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue.</p>'
]
var instr_ViewVideos = [
    style_instr + '<strong> THIS OPTION IS ONLY AVAILABLE DURING PROJECT DEVELOPMENT</strong>:<br><br>Would you like to view the video or skip the video?</p>'
]
var instr_Consent = [
    style_instr_nowidth + "Before completing any study tasks, please review the following consent document and indicate whether you consent to study participation.</p>"
]
var instr_NoConsent = [
    style_instr + 'You did not consent to participate. The session will now finish. Thank you for your time!<br><br><br><a href="https://app.prolific.co/">Click here to return to Prolific and complete the study</a>.</p>'
]
var instr_Intro =[
    style_instr + 'Thank you for agreeing to participate in this experiment! <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + 'Before we begin, please be sure that you are in a good space to complete the experiment. This space should be: <br><br><br><br> <strong>Comfortable <br><br> Distraction-free <br><br> Available for the next 20 minutes</strong> <br><br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + '<strong>Please give your full attention to the experiment. This includes:</strong> <br><br><br><br> Closing or minimizing other programs on your computer <br><br> Silencing your phone or placing it somewhere it will not be distracting <br><br> Testing that your audio is working and set to a comfortable volume that you can clearly hear <br><br> Not completing this experiment with others present <br><br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + 'During this experiment, you will watch four short clips from horror movies. These clips may elicit some negative or unwanted emotional reactions. <br><br><br> <strong> Please watch and react to these clips as you naturally would</strong>. Before and after every clip, you will record the intensity of your negative emotions. You will also answer questions regarding your thoughts, behaviors, or experiences after watching all of the clips. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
]
var instr_Video_Reminder_1st = [
    style_instr + 'You will now watch one of the clips. <br><br><br> As a reminder, watch and react to this video <strong>as you naturally would</strong>.<br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue.</p>'
]
var instr_Video_Reminder_Not1st = [
    style_instr + 'You will now watch another one of the clips. <br><br><br> As a reminder, watch and react to this video <strong>as you naturally would</strong>.<br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue.</p>'
]
var text_Intense_Baseline = [
    style_instr_nowidth + 'How <strong>intense</strong> are the negative emotions that you feel <strong>before</strong> starting this clip?</p>'
]
var text_Intense_Stim = [
    style_instr_nowidth +'How <strong>intense</strong> were the negative emotions that you felt <strong>while</strong> watching this clip?</p>'
]
var prompt_IntenseVideo = [
    style_instr_nowidth + "Before this video, you reported<br>your negative emotions were a:<br>" + '<span style="color: green;"><font size="+15"><strong>'
]
var instr_Strats_A = [
    style_instr + 'You have watched all of the video clips. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + 'You will now answer questions about emotion regulation during the videos you watched. Please read the directions closely and answer honestly. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
    style_instr + 'When we experience emotions that we do not want, we often times try to change, or regulate, them. <br><br><br> For example, if a break-up with a significant other upsets us, we can distract ourselves by spending time with friends or we could reframe the event as an opportunity for a new beginning. <br><br><br> Both regulation strategies will likely change our emotional experience, however, we may choose different strategies for different reasons. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
    style_instr + 'One common emotion regulation strategy is <strong>REAPPRAISAL</strong> <br><br><br><br> Reappraisal involves thinking about the unwanted emotional experience or  object in such a way to change its emotional meaning. <br><br><br> When reappraising, we change the way we think about the experience or object such that it alters the emotional reaction to it. <br><br><br> For example, in the context of a horror movie, you could make an effort to remind yourself that the people are just actors who are using props, rather than actual zombies. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + 'Another common emotion regulation strategy is <strong>DISTRACTION</strong> <br><br><br><br> Distraction involves looking at or thinking about something besides the unwanted emotional experience or object. <br><br><br> When distracting, we divert our attention to disengage with the experience or object, thus altering our emotional reactions. <br><br><br> For example, in the context of a horror movie, you could choose to look away from the screen or think about what you ate for lunch rather than focusing on the zombies on screen. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
]
var instr_Strats_B = [
    style_instr + 'You have watched all of the video clips. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>', 
    style_instr + 'You will now answer questions about emotion regulation during the videos you watched. Please read the directions closely and answer honestly. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
    style_instr + 'When we experience emotions that we do not want, we often times try to change, or regulate, them. <br><br><br> For example, if a break-up with a significant other upsets us, we can distract ourselves by spending time with friends or we could reframe the event as an opportunity for a new beginning. <br><br><br> Both regulation strategies will likely change our emotional experience, however, we may choose different strategies for different reasons. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
    style_instr + 'One common emotion regulation strategy is <strong>DISTRACTION</strong> <br><br><br><br> Distraction involves looking at or thinking about something besides the unwanted emotional experience or object. <br><br><br> When distracting, we divert our attention to disengage with the experience or object, thus altering our emotional reactions. <br><br><br> For example, in the context of a horror movie, you could choose to look away from the screen or think about what you ate for lunch rather than focusing on the zombies on screen. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
    style_instr + 'Another common emotion regulation strategy is <strong>REAPPRAISAL</strong> <br><br><br><br> Reappraisal involves thinking about the unwanted emotional experience or  object in such a way to change its emotional meaning. <br><br><br> When reappraising, we change the way we think about the experience or object such that it alters the emotional reaction to it. <br><br><br> For example, in the context of a horror movie, you could make an effort to remind yourself that the people are just actors who are using props, rather than actual zombies. <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>',
]
var text_Strategy_Experience = [
    style_question +'Which strategy, if any, did you use to regulate your negative emotions while watching this clip?</p>'
]
var text_Strategy_Forecast = [
    style_question +'Which strategy, if any, would you predict the average person would use to regulate their negative emotions while watching this clip?</p>'
]
var instr_StrategyDesc_Experience_A = [
    style_strat_descs + 
    '<div class="column">' + style_response_labels + '<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
    '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
    '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Experience_B = [
    style_strat_descs +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
    '</div>'
]
var instr_StrategyDesc_Experience_C = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Experience_D = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Experience_E = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Experience_F = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if you did not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if you diverted your attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if you changed how you thought about the video</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Forecast_A = [
    style_strat_descs + 
    '<div class="column">' + style_response_labels + '<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
    '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
    '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Forecast_B = [
    style_strat_descs +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
        '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
    '</div>'
]
var instr_StrategyDesc_Forecast_C = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Forecast_D = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Forecast_E = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
  '</div>'
]
var instr_StrategyDesc_Forecast_F = [
    style_strat_descs +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE NEITHER</strong> if they should not implement either of the other two strategies</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE DISTRACTION</strong> if they should divert their attention from the video</p></div>' +
     '<div class="column">'+ style_response_labels +'<strong>CHOOSE REAPPRAISAL</strong> if they should change how they thought about the video</p></div>' +
  '</div>'
]
var text_Reduce_Experience = [
    '<div style="width:1300px;">' +
        '<p style="font-size: 30px; line-height: 34px;">How much did the strategy you used <strong>reduce</strong> the intensity of your negative emotions?</p>'
]
var text_Reduce_Forecast = [
    '<div style="width:1300px;">' +
        '<p style="font-size: 30px; line-height: 34px;">' + "How much do you predict the strategy you chose would <strong>reduce</strong> the intensity of the average person's negative emotions?</p>"
]
var text_Effort_Experience = [
    style_likert + 'Though someone may choose a specific strategy, the effort required to use that strategy may vary by situation.<br><br>How <strong>effortful</strong> was it to use the regulation strategy that you had chosen while watching this clip?</p>'
]
var text_Effort_Forecast = [
    style_likert + 'Though someone may choose a specific strategy, the effort required to use that strategy may vary by situation.<br><br>How <strong>effortful</strong> do you predict the average other person would find using the regulation strategy that you had chosen while watching this clip?</p>'
]
var text_Success_Experience = [
    style_likert + 'Though someone may choose a specific strategy, whether we are able to fully use it may vary by situation.<br><br>How <strong>successfully</strong> were you able to employ the regulation strategy that you had chosen while watching this clip?</p>'
]
var text_Success_Forecast = [
    style_likert + 'Though someone may choose a specific strategy, whether we are able to fully use it may vary by situation.<br><br>How <strong>successfully</strong> do you predict the average other person could employ the regulation strategy that you had chosen while watching this clip?</p>'
]
var instr_ExpStart = [
    style_instr + "The experiment will now start! <br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>"
]
var instr_IndDiff = [
    style_instr +'You have just completed our video task! Thank you for your continued effort and attention. <br><br> In our final task, we will ask you questions about yourself. Please read the instructions before each series of questions and answer the questions honestly to the best of your abiltities.<br><br><br><br> Please press the <strong>SPACE BAR</strong> to continue</p>'
]
var instr_ExpEnd = [
    style_instr + 'Thank you for completing the study! <br><br><br><br> Please press the <strong>SPACE BAR</strong> to automatically reroute back to Prolific to complete your study partcipation.</p>'
]