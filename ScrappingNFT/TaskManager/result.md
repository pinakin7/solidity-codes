PS E:\TechNomads\D-App\TaskManager> truffle console
truffle(development)> todolist = await TodoList.deployed()
undefined
truffle(development)> todolist
TruffleContract {
  constructor: [Function: TruffleContract] {
    _constructorMethods: {
      configureNetwork: [Function: configureNetwork],
      setProvider: [Function: setProvider],
      new: [Function: new],
      at: [AsyncFunction: at],
      deployed: [AsyncFunction: deployed],
      defaults: [Function: defaults],
      hasNetwork: [Function: hasNetwork],
      isDeployed: [Function: isDeployed],
      detectNetwork: [AsyncFunction: detectNetwork], 
      setNetwork: [Function: setNetwork],
      setNetworkType: [Function: setNetworkType],    
      setWallet: [Function: setWallet],
      resetAddress: [Function: resetAddress],        
      link: [Function: link],
      clone: [Function: clone],
      addProp: [Function: addProp],
      toJSON: [Function: toJSON],
      decodeLogs: [Function: decodeLogs]
    },
    _properties: {
      contract_name: [Object],
      contractName: [Object],
      gasMultiplier: [Object],
      timeoutBlocks: [Object],
      autoGas: [Object],
      numberFormat: [Object],
      abi: [Object],
      metadata: [Function: metadata],
      network: [Function: network],
      networks: [Function: networks],
      address: [Object],
      transactionHash: [Object],
      links: [Function: links],
      events: [Function: events],
      binary: [Function: binary],
      deployedBinary: [Function: deployedBinary],
      unlinked_binary: [Object],
      bytecode: [Object],
      deployedBytecode: [Object],
      sourceMap: [Object],
      deployedSourceMap: [Object],
      source: [Object],
      sourcePath: [Object],
      legacyAST: [Object],
      ast: [Object],
      compiler: [Object],
      schema_version: [Function: schema_version],
      schemaVersion: [Function: schemaVersion],
      updated_at: [Function: updated_at],
      updatedAt: [Function: updatedAt],
      userdoc: [Function: userdoc],
      devdoc: [Function: devdoc],
      networkType: [Object],
      immutableReferences: [Object],
      generatedSources: [Object],
      deployedGeneratedSources: [Object],
      db: [Object]
    },
    _property_values: {},
    _json: {
      contractName: 'TodoList',
      abi: [Array],
      metadata: '{"compiler":{"version":"0.8.11+commit.d7f03943"},"language":"Solidity","output":{"abi":[{"inputs":[],"name":"taskCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}],"devdoc":{"kind":"dev","methods":{},"version":1},"userdoc":{"kind":"user","methods":{},"version":1}},"settings":{"compilationTarget":{"project:/contracts/TodoList.sol":"TodoList"},"evmVersion":"london","libraries":{},"metadata":{"bytecodeHash":"ipfs"},"optimizer":{"enabled":false,"runs":200},"remappings":[]},"sources":{"project:/contracts/TodoList.sol":{"keccak256":"0x980eb02b932fed2d0e171716aac64c6e545438ac9104677cc6d6f28e307ebc74","urls":["bzz-raw://f6f05b6f1b30ea909c92a4241c8d0002249be2e4ca61bd1dd023dc23450d7199","dweb:/ipfs/QmY5AME4KBvwKZ8GgZpGZjaqf86EDo72vBYYHRyH3eryrt"]}},"version":1}',
      bytecode: '0x608060405234801561001057600080fd5b5060b38061001f6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c8063b6cb58a514602d575b600080fd5b60336047565b604051603e91906064565b60405180910390f35b60005481565b6000819050919050565b605e81604d565b82525050565b6000602082019050607760008301846057565b9291505056fea264697066735822122089392c4070ce94b525706f6d18fe314aa323cedc08b41e535a80852b2494fcb064736f6c634300080b0033',
      deployedBytecode: '0x6080604052348015600f57600080fd5b506004361060285760003560e01c8063b6cb58a514602d575b600080fd5b60336047565b604051603e91906064565b60405180910390f35b60005481565b6000819050919050565b605e81604d565b82525050565b6000602082019050607760008301846057565b9291505056fea264697066735822122089392c4070ce94b525706f6d18fe314aa323cedc08b41e535a80852b2494fcb064736f6c634300080b0033',
      immutableReferences: {},
      generatedSources: [],
      deployedGeneratedSources: [Array],
      sourceMap: '63:138:1:-:0;;;;;;;;;;;;;;;;;;;',
      deployedSourceMap: '63:138:1:-:0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;176:21;;;:::i;:::-;;;;;;;:::i;:::-;;;;;;;;;;;;:::o;7:77:2:-;44:7;73:5;62:16;;7:77;;;:::o;90:118::-;177:24;195:5;177:24;:::i;:::-;172:3;165:37;90:118;;:::o;214:222::-;307:4;345:2;334:9;330:18;322:26;;358:71;426:1;415:9;411:17;402:6;358:71;:::i;:::-;214:222;;;;:::o',     
      source: '// smart contract for todo list\r\n' +
        '\r\n' +
        'pragma solidity >=0.5.0;\r\n' +
        '\r\n' +
        'contract TodoList{\r\n' +
        '    // keep track for number of task in the list\r\n' +
        '\r\n' +
        '    // declaring the state variable\r\n' +
        '    uint public taskCount;\r\n' +
        '}',
      sourcePath: 'E:\\TechNomads\\D-App\\TaskManager\\contracts\\TodoList.sol',
      ast: [Object],
      legacyAST: [Object],
      compiler: [Object],
      networks: [Object],
      schemaVersion: '3.4.4',
      updatedAt: '2022-01-26T06:26:56.517Z',
      networkType: 'ethereum',
      devdoc: [Object],
      userdoc: [Object],
      db: undefined
    },
    configureNetwork: [Function: bound configureNetwork],
    setProvider: [Function: bound setProvider],
    new: [Function: bound new] {
      estimateGas: [Function: bound estimateDeployment],
      request: [Function: bound requestDeployment]
    },
    at: [Function: bound at] AsyncFunction,
    deployed: [Function: bound deployed] AsyncFunction,
    defaults: [Function: bound defaults],
    hasNetwork: [Function: bound hasNetwork],
    isDeployed: [Function: bound isDeployed],
    detectNetwork: [Function: bound detectNetwork] AsyncFunction,
    setNetwork: [Function: bound setNetwork],
    setNetworkType: [Function: bound setNetworkType],
    setWallet: [Function: bound setWallet],
    resetAddress: [Function: bound resetAddress],
    link: [Function: bound link],
    clone: [Function: bound clone],
    addProp: [Function: bound addProp],
    toJSON: [Function: bound toJSON],
    decodeLogs: [Function: bound decodeLogs],
    enums: {},
    class_defaults: { from: '0x4835E05105572f35e0372f8bf880cdBbCbA8bF66' },
    interfaceAdapter: Web3InterfaceAdapter { web3: [Web3Shim] },
    web3: Web3Shim {
      currentProvider: [Getter/Setter],
      _requestManager: [RequestManager],
      givenProvider: null,
      providers: [Object],
      _provider: [HttpProvider],
      setProvider: [Function (anonymous)],
      setRequestManager: [Function (anonymous)],
      BatchRequest: [Function: bound Batch],
      extend: [Function],
      version: '1.5.3',
      utils: [Object],
      eth: [Eth],
      shh: [Shh],
      bzz: [Bzz],
      networkType: 'ethereum'
    },
    currentProvider: HttpProvider {
      withCredentials: false,
      timeout: 0,
      headers: undefined,
      agent: undefined,
      connected: true,
      host: 'http://127.0.0.1:7545',
      httpAgent: [Agent],
      send: [Function (anonymous)],
      _alreadyWrapped: true
    },
    network_id: '5777',
    disableConfirmationListener: undefined,
    ens: { enabled: false, registryAddress: null }
  },
  methods: {
    'taskCount()': [Function (anonymous)] {
      call: [Function (anonymous)],
      sendTransaction: [Function (anonymous)],
      estimateGas: [Function (anonymous)],
      request: [Function (anonymous)]
    }
  },
  abi: [
    {
      inputs: [],
      name: 'taskCount',
      outputs: [Array],
      stateMutability: 'view',
      type: 'function',
      constant: true,
      payable: undefined,
      signature: '0xb6cb58a5'
    }
  ],
  address: '0x14DDBB534BB568eAF92acA13867F1D2DEB910c13',
  transactionHash: undefined,
  contract: Contract {
    setProvider: [Function (anonymous)],
    currentProvider: [Getter/Setter],
    _requestManager: RequestManager {
      provider: [HttpProvider],
      providers: [Object],
      subscriptions: Map(0) {}
    },
    givenProvider: null,
    providers: {
      WebsocketProvider: [Function: WebsocketProvider],
      HttpProvider: [Function: HttpProvider],
      IpcProvider: [Function: IpcProvider]
    },
    _provider: HttpProvider {
      withCredentials: false,
      timeout: 0,
      headers: undefined,
      agent: undefined,
      connected: true,
      host: 'http://127.0.0.1:7545',
      httpAgent: [Agent],
      send: [Function (anonymous)],
      _alreadyWrapped: true
    },
    setRequestManager: [Function (anonymous)],
    BatchRequest: [Function: bound Batch],
    extend: [Function: ex] {
      formatters: [Object],
      utils: [Object],
      Method: [Function: Method]
    },
    clearSubscriptions: [Function (anonymous)],
    options: { address: [Getter/Setter], jsonInterface: [Getter/Setter] },
    handleRevert: [Getter/Setter],
    defaultCommon: [Getter/Setter],
    defaultHardfork: [Getter/Setter],
    defaultChain: [Getter/Setter],
    transactionPollingTimeout: [Getter/Setter],
    transactionConfirmationBlocks: [Getter/Setter],
    transactionBlockTimeout: [Getter/Setter],
    defaultAccount: [Getter/Setter],
    defaultBlock: [Getter/Setter],
    methods: {
      taskCount: [Function: bound _createTxObject],
      '0xb6cb58a5': [Function: bound _createTxObject],
      'taskCount()': [Function: bound _createTxObject]
    },
    events: { allEvents: [Function: bound ] },
    _address: '0x14DDBB534BB568eAF92acA13867F1D2DEB910c13',
    _jsonInterface: [ [Object] ]
  },
  taskCount: [Function (anonymous)] {
    call: [Function (anonymous)],
    sendTransaction: [Function (anonymous)],
    estimateGas: [Function (anonymous)],
    request: [Function (anonymous)]
  },
  sendTransaction: [Function (anonymous)],
  send: [Function (anonymous)],
  allEvents: [Function (anonymous)],
  getPastEvents: [Function (anonymous)]
}
truffle(development)> todolist.address
'0x14DDBB534BB568eAF92acA13867F1D2DEB910c13'
truffle(development)> todolist.taskCount()
BN { negative: 0, words: [ 0, <1 empty item> ], length: 1, red: null }
truffle(development)> taskcount = await todolist.taskCount()
undefined
truffle(development)> taskcount.toNumber()
0
truffle(development)>





PS E:\TechNomads\D-App\TaskManager> truffle console        
truffle(development)> todolist = await TodoList.deployed()
undefined
truffle(development)> todolist.address
'0x7DB5CD1aAfaE56022cB67Bb67217Fb72aAE99DfB'
truffle(development)> task = await todolist.tasks(1)
undefined
truffle(development)> task
Result {
  '0': BN {
    negative: 0,
    words: [ 1, <1 empty item> ],
    length: 1,
    red: null
  },
  '1': 'Creating my first task',
  '2': false,
  id: BN {
    negative: 0,
    words: [ 1, <1 empty item> ],
    length: 1,
    red: null
  },
  content: 'Creating my first task',
  completed: false
}
truffle(development)> task.id.toNumber()
1
truffle(development)> task.content
'Creating my first task'
truffle(development)> task.completed
false
truffle(development)>