const sudo = require('sudo-prompt');
const options = {
  name: 'pargar',
};

const command = 'sudo sysctl net.ipv4.ip_forward=1';

sudo.exec(command, options, function(error, stdout, stderr) {
  if (error) throw error;
  console.log('stdout: ' + stdout);
});
