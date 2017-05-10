import socket from './channels';

export default function init() {
  socket.connect();

  const sysChannel = socket.channel('room:sys');
  const svsChannel = socket.channel('room:services');
  const logChannel = socket.channel('room:logs');
  sysChannel.join()
    .receive('ok', () => console.log('Sys channel Joined'));
  svsChannel.join()
    .receive('ok', () => console.log('Services channel Joined'));
  logChannel.join()
    .receive('ok', () => console.log('Logs channel Joined'));
}
