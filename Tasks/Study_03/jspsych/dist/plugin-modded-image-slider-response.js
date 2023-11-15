var jsPsychImageSliderResponse = (function (jspsych) {
  'use strict';

  const info = {
      name: "image-slider-response",
      parameters: {
          /** The image to be displayed */
          stimulus: {
              type: jspsych.ParameterType.IMAGE,
              pretty_name: "Stimulus",
              default: undefined,
          },
          /** Set the image height in pixels */
          stimulus_height: {
            type: jspsych.ParameterType.INT,
            pretty_name: "Image height",
            default: null,
        },
        /** Set the image width in pixels */
        stimulus_width: {
            type: jspsych.ParameterType.INT,
            pretty_name: "Image width",
            default: null,
        },
        /** Maintain the aspect ratio after setting width or height */
        maintain_aspect_ratio: {
            type: jspsych.ParameterType.BOOL,
            pretty_name: "Maintain aspect ratio",
            default: true,
        },
          /** Sets the minimum value of the slider. */
          min: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Min slider",
              default: 0,
          },
          /** Sets the maximum value of the slider */
          max: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Max slider",
              default: 100,
          },
          /** Sets the starting value of the slider */
          slider_start: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Slider starting value",
              default: 50,
          },
          /** Sets the step of the slider */
          step: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Step",
              default: 1,
          },
          /** Array containing the labels for the slider. Labels will be displayed at equidistant locations along the slider. */
          labels: {
              type: jspsych.ParameterType.HTML_STRING,
              pretty_name: "Labels",
              default: [],
              array: true,
          },
          /** Width of the slider in pixels. */
          slider_width: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Slider width",
              default: null,
          },
          /** Whether the value of the slider should be displayed. */
          show_value: {
            type: jspsych.ParameterType.BOOL,
            pretty_name: "Show value",
            default: false,
          },
          /** Reverse the value displayed by the slider. */
          reverse_value: {
            type: jspsych.ParameterType.BOOL,
            pretty_name: "Reverse value",
            default: false,
          },
          /** Label of the button to advance. */
          button_label: {
              type: jspsych.ParameterType.STRING,
              pretty_name: "Button label",
              default: "Continue",
              array: false,
          },
          /** If true, the participant will have to move the slider before continuing. */
          require_movement: {
              type: jspsych.ParameterType.BOOL,
              pretty_name: "Require movement",
              default: false,
          },
          /** Any content here will be displayed above the slider. */
          upper_prompt: {
              type: jspsych.ParameterType.HTML_STRING,
              pretty_name: "Upper Prompt",
              default: null,
          },
          /** Any content here will be displayed below the slider. */
          lower_prompt: {
              type: jspsych.ParameterType.HTML_STRING,
              pretty_name: "Lower Prompt",
              default: null,
          },
          /** How long to show the stimulus. */
          stimulus_duration: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Stimulus duration",
              default: null,
          },
          /** How long to show the trial. */
          trial_duration: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Trial duration",
              default: null,
          },
          /** If true, trial will end when user makes a response. */
          response_ends_trial: {
              type: jspsych.ParameterType.BOOL,
              pretty_name: "Response ends trial",
              default: true,
          },
          /** If a numeric value is provided, a red marker will appear on the slider at this point. */
          marker_value: {
              type: jspsych.ParameterType.INT,
              pretty_name: "Value of Slider Marker",
              default: null,
          },
      },
  };
  /**
   * **image-slider-response**
   *
   * jsPsych plugin for showing an image stimulus and collecting a slider response
   *
   * @author Josh de Leeuw
   * @see {@link https://www.jspsych.org/plugins/jspsych-image-slider-response/ image-slider-response plugin documentation on jspsych.org}
   */
  class ImageSliderResponsePlugin {
      constructor(jsPsych) {
          this.jsPsych = jsPsych;
      }
      trial(display_element, trial) {
          // half of the thumb width value from jspsych.css, used to adjust the label positions
          var half_thumb_width = 7.5;
          var html = "";
          html = '<div id="jspsych-image-slider-response-wrapper" style="margin: 100px 0px;">';
          if (trial.upper_prompt !== null) {
            html += trial.upper_prompt;
          }
          html += '<div id="jspsych-image-slider-response-stimulus">';
          html += '<img src="' + trial.stimulus + '" style="';
          if (trial.stimulus_height !== null) {
              html += "height:" + trial.stimulus_height + "px; ";
              if (trial.stimulus_width == null && trial.maintain_aspect_ratio) {
                  html += "width: auto; ";
              }
          }
          if (trial.stimulus_width !== null) {
              html += "width:" + trial.stimulus_width + "px; ";
              if (trial.stimulus_height == null && trial.maintain_aspect_ratio) {
                  html += "height: auto; ";
              }
          }
          html += '"></img>';
          html += "</div><br>";
          if (trial.show_value){
            html +=
                '<div class="jspsych-image-slider-response-container" style="display: flex; align-items: center; position:relative; margin: 0 auto 3em auto; ';
          }
          else {
            html +=
                '<div class="jspsych-image-slider-response-container" style="position:relative; margin: 0 auto 3em auto; ';
          }

          if (trial.slider_width !== null) {
              html += "width:" + trial.slider_width + "px;";
          }
          else {
              html += "width:auto;";
          }
          html += '">';
          html +=
              '<input type="range" class="jspsych-slider" value="' +
                  trial.slider_start +
                  '" min="' +
                  trial.min +
                  '" max="' +
                  trial.max +                 
                  '" step="' +
                  trial.step +
                  '" id="jspsych-image-slider-response-response"'
          if (trial.show_value){
            if (trial.reverse_value == false){
                html += 'oninput="rangeValue.innerText = this.value"><font size="+2"><b><p id="rangeValue" style="padding-left: 20px;">50</p></b></font>';
            }    
            if (trial.reverse_value){
                html += 'oninput="rangeValue.innerText = 100 - this.value"><font size="+2"><b><p id="rangeValue" style="padding-left: 20px;">50</p></b></font>';
            }  
          }
          else {
            html += '>';
          }
          html += "</input>"
          // MODIFICATION: Adding a marker to indicate certain values as needed
          // Note: I never quite got this modification to work. This is because of the modifications I added to visualize the marker position; they appear to conflict because the scale is shortened, resulting in the marker always being slightly out of place. 
          if (trial.marker_value){
            html += '<div class="jspsych-slider-marker" id="sliderMarker" style="left:' +
            marker_value_adj +
            '%);"></div>'
          }
          html += "<div>";
          // Labels 
          for (var j = 0; j < trial.labels.length; j++) {
              var label_width_perc = 100 / (trial.labels.length - 1);
              var percent_of_range = j * (100 / (trial.labels.length - 1));
              var percent_dist_from_center = ((percent_of_range - 50) / 50) * 100;
              var offset = (percent_dist_from_center * half_thumb_width) / 100;
              html +=
                  '<div style="border: 1px solid transparent; display: inline-block; position: absolute; ' +
                      "left:calc(" +
                      percent_of_range +
                      "% - (" +
                      label_width_perc +
                      "% / 2) - " +
                      offset +
                      "px); text-align: center; width: " +
                      label_width_perc +
                      '%;">';
              html += '<span style="text-align: center; font-size: 80%;">' + trial.labels[j] + "</span>";
              html += "</div>";
          }
          html += "</div>";
          html += "</div>";
          html += "</div>";
          if (trial.lower_prompt !== null) {
              html += trial.lower_prompt;
          }
          // add submit button
          html +=
              '<button id="jspsych-image-slider-response-next" class="jspsych-btn" ' +
                  (trial.require_movement ? "disabled" : "") +
                  ">" +
                  trial.button_label +
                  "</button>";
          display_element.innerHTML = html;
          var response = {
              rt: null,
              response: null,
          };
          if (trial.require_movement) {
              const enable_button = () => {
                  display_element.querySelector("#jspsych-image-slider-response-next").disabled = false;
              };
              display_element
                  .querySelector("#jspsych-image-slider-response-response")
                  .addEventListener("mousedown", enable_button);
              display_element
                  .querySelector("#jspsych-image-slider-response-response")
                  .addEventListener("touchstart", enable_button);
              display_element
                  .querySelector("#jspsych-image-slider-response-response")
                  .addEventListener("change", enable_button);
          }
          const end_trial = () => {
              this.jsPsych.pluginAPI.clearAllTimeouts();
              // save data
              var trialdata = {
                  rt: response.rt,
                  stimulus: trial.stimulus,
                  slider_start: trial.slider_start,
                  response: response.response,
              };
              display_element.innerHTML = "";
              // next trial
              this.jsPsych.finishTrial(trialdata);
          };
          display_element
              .querySelector("#jspsych-image-slider-response-next")
              .addEventListener("click", () => {
              // measure response time
              var endTime = performance.now();
              response.rt = Math.round(endTime - startTime);
              response.response = display_element.querySelector("#jspsych-image-slider-response-response").valueAsNumber;
              if (trial.reverse_value){
                response.response = trial.max - response.response 
              } 
              if (trial.response_ends_trial) {
                  end_trial();
              }
              else {
                  display_element.querySelector("#jspsych-image-slider-response-next").disabled = true;
              }
          });
          if (trial.stimulus_duration !== null) {
              this.jsPsych.pluginAPI.setTimeout(() => {
                  display_element.querySelector("#jspsych-image-slider-response-stimulus").style.visibility = "hidden";
              }, trial.stimulus_duration);
          }
          // end trial if trial_duration is set
          if (trial.trial_duration !== null) {
              this.jsPsych.pluginAPI.setTimeout(end_trial, trial.trial_duration);
          }
          var startTime = performance.now();
      }
      
      simulate(trial, simulation_mode, simulation_options, load_callback) {
          if (simulation_mode == "data-only") {
              load_callback();
              this.simulate_data_only(trial, simulation_options);
          }
          if (simulation_mode == "visual") {
              this.simulate_visual(trial, simulation_options, load_callback);
          }
      }
      create_simulation_data(trial, simulation_options) {
          const default_data = {
              stimulus: trial.stimulus,
              slider_start: trial.slider_start,
              response: this.jsPsych.randomization.randomInt(trial.min, trial.max),
              rt: this.jsPsych.randomization.sampleExGaussian(500, 50, 1 / 150, true),
          };
          const data = this.jsPsych.pluginAPI.mergeSimulationData(default_data, simulation_options);
          this.jsPsych.pluginAPI.ensureSimulationDataConsistency(trial, data);
          return data;
      }
      simulate_data_only(trial, simulation_options) {
          const data = this.create_simulation_data(trial, simulation_options);
          this.jsPsych.finishTrial(data);
      }
      simulate_visual(trial, simulation_options, load_callback) {
          const data = this.create_simulation_data(trial, simulation_options);
          const display_element = this.jsPsych.getDisplayElement();
          this.trial(display_element, trial);
          load_callback();
          if (data.rt !== null) {
              const el = display_element.querySelector("input[type='range']");
              setTimeout(() => {
                  this.jsPsych.pluginAPI.clickTarget(el);
                  el.valueAsNumber = data.response;
              }, data.rt / 2);
              this.jsPsych.pluginAPI.clickTarget(display_element.querySelector("button"), data.rt);
          }
      }
  }
  ImageSliderResponsePlugin.info = info;

  return ImageSliderResponsePlugin;

})(jsPsychModule);
