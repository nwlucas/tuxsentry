import socket from './channels';

export default function init() {
  socket.connect();

  const sysChannel = socket.channel('room:sys');
  const svsChannel = socket.channel('room:services');
  const logChannel = socket.channel('room:logs');
  sysChannel.join()
    .receive('ok', response => { console.log('Sys channel joined', response); })
    .receive('error', response => { console.log('Unable to join the sys channel', response); })
  svsChannel.join()
  .receive('ok', response => { console.log('Services channel joined', response); })
  .receive('error', response => { console.log('Unable to join the services channel', response); })
  logChannel.join()
  .receive('ok', response => { console.log('Logs channel joined', response); })
  .receive('error', response => { console.log('Unable to join the logs channel', response); })
}
