import { Socket } from 'phoenix-elixir';
import { socketURL } from '../utils';

const socket = new Socket(socketURL);

export default socket;
