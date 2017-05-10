import { Socket } from 'phoenix-elixir';
import { socketURL } from '../utils';

const socket = new Socket(socketURL, { params: { token: window.userToken } });
console.log('Token: ', window.userToken);
export default socket;
