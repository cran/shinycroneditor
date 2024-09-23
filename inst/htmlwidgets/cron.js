HTMLWidgets.widget({
  name: "cron",
  type: "output",

  initialize: function(el, width, height) {
    // Load the language file dynamically (needs to be done first, before the main script is loaded)
    var languageScript = document.createElement('script');
    languageScript.src = 'cron-expression-input-1.3.1/lib/' + $(el).parent().data("language") + '.js';
    document.head.appendChild(languageScript);
    
  },

  renderValue: function(el, x) {

    // Immediately send the initial value back to Shiny
    if (HTMLWidgets.shinyMode) {
      Shiny.onInputChange(el.id, x.schedule);
    }

    // Clear any existing cron
    el.replaceChildren();
    
    // Create the cron expression input (Web Component)
    var cronInput = document.createElement("cron-expression-input");
    cronInput.setAttribute("id", el.id + "_input");
    cronInput.setAttribute("value", x.schedule);
    cronInput.setAttribute("height", x.height ?? "34px");
    cronInput.setAttribute("width", x.width ?? "250px");
    cronInput.setAttribute("color", x.color ?? "#d58581");
    cronInput.setAttribute("hot-validate", x.hotValidate ?? "true");
    
    el.appendChild(cronInput);
    
    // Load the script that renders the cron input ui
    // This is a bit hacky but needs to be done after rendering,
    // as the language files are otherwise not interpreted).
    if (! document.getElementById("cron_expression_input_script")) {
      var mainScript = document.createElement('script');
      mainScript.id = "cron_expression_input_script";
      mainScript.src = 'cron-expression-input-1.3.1/lib/cron-expression-input.min.js';
      document.head.appendChild(mainScript);
    }

    // Listen for 'change' event (if emitted by the component)
    // We can't use the htmlwidgets' oninput function as this is a web component
    cronInput.addEventListener('change', function() {
      
      if (HTMLWidgets.shinyMode) {
        Shiny.onInputChange(
          el.id, 
          $(this).find("input.cronInsideInput").val()
        );
      }
      
    });

  },
  
  resize: function(el, width, height) {
    // Code to handle resizing, if needed
  }
});