const { socketScheme, scheme, hostname } =
  process.env.NODE_ENV === 'production'
  ? { socketScheme: 'wss', scheme: 'https', hostname: window.location.hostname }
  : { socketScheme: 'ws', scheme: 'http', hostname: 'localhost:4000' };

const defaultHeaders = {
  Accept: 'application/json',
  'Content-Type': 'application/json'
};

const apiURL = `${scheme}://${hostname}/sys`;
const socketURL = `${socketScheme}://${hostname}/socket`;

export { socketURL, apiURL, defaultHeaders };
