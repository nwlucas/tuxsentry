import { Socket } from 'phoenix-socket';
import { socketURL } from '../utils';

const socket = new Socket(socketURL, { params: { token: window.userToken } });
console.log('Token: ', window.userToken);
export default socket;
