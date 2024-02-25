const sudo = require('sudo-prompt');
const options = {
  name: 'Your Application Name',
};

const command = 'echo hi ';

sudo.exec(command, options, function(error, stdout, stderr) {
  if (error) throw error;
  console.log('stdout: ' + stdout);
});
