complete -c tensorboard -l logdir -d 'Directory where TensorBoard will look to find TensorFlow event files that it can display. TensorBoard will recursively walk the directory structure rooted at logdir, looking for .*tfevents.* files. A leading tilde will be expanded with the semantics of Python\'s os.expanduser function.'
complete -c tensorboard -l bind_all -d 'Serve on all public interfaces. This will expose your TensorBoard instance to the network on both IPv4 and IPv6 (where available). Mutually exclusive with `--host`.'
complete -c tensorboard -l help -d 'Print help'
complete -c tensorboard -l version -d 'Print version'
