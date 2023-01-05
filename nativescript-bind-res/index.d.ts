declare module "App.bs" {
  type port = any
  type config = {
    elmModule: () => any,
    elmModuleName: string,
    flags?: any,
    initPorts?: (ports: port) => void,
  }
  export function start(config: config): void;
}
