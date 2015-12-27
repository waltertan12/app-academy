/* global React, Note, Key, Recorder */

(function(root) {
  'use strict';

  if (typeof root.Organ === "undefined") {
    root.Organ = {};
  }

  var Organ = root.Organ = React.createClass({
    render: function () {
      return (
        <div className="container">
          <h1>synthakeyorganApp</h1>
          <h5><em>
            you are literally Beethoven
          </em></h5>
          <div className="keyboard container keyboard-upper">
          {
            Object.keys(window.UPPER_TONES).map(function (tone, idx) {
              return <Key noteName={tone} key={idx}/>;
            })
          }
          </div>
          <br className="clearfix"/>

          <div className="keyboard container keyboard-lower">
          {
            Object.keys(window.LOWER_TONES).map(function (tone, idx) {
              return <Key noteName={tone} key={idx}/>;
            })
          }
          </div>
          <div className="clearfix"/>
          <br/><br/>
          <Recorder className="Recorder" />
        </div>
      );
    }
  });
}(this));
