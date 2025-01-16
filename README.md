![The angry old 'Get off my port!' man doesn't appreciate squatters.](resources/mascot-384x384.png)

# Get off my port! - find and kill processes that steal your network ports

It happens just often enough to regularly waste your time without leading to a durable solution: some uppity young process takes the port you obviously want and laughs in your face. You keep finding yourself Googling "what's using port 80?" and "how to permanently disable Mac's built-in Apache server" (as a not-so-random example), but it never sticks. `get-off-my-port` finds out what's using the port and kills it so you can get back to work.

Note: it's not a permanent solution. It's a quick hack to get you unblocked in a pinch, and you'll probably have to do it again the next time you reboot. Also, it's a power tool--be careful where you point it.

## Installation

To install, simply download the script, make it executable, and place it somewhere in your `$PATH`. For example:

```shell
curl -o /usr/local/bin/get-off-my-port https://raw.githubusercontent.com/TravisCarden/get-off-my-port/refs/heads/main/get-off-my-port && \
chmod +x /usr/local/bin/get-off-my-port
```

Note: You may need to use sudo if you don’t have write permissions for `/usr/local/bin`:

```shell
sudo curl -o /usr/local/bin/get-off-my-port https://raw.githubusercontent.com/TravisCarden/get-off-my-port/refs/heads/main/get-off-my-port && \
sudo chmod +x /usr/local/bin/get-off-my-port
```

You might also like to rename it to something shorter, like `gomp`, if that name's not taken on your machine. (See how thoughtful I was about that, [GNU Offloading and Multi-Processing Project](https://gcc.gnu.org/projects/gomp/) and [Git cOMPare](https://github.com/MarkForged/GOMP)?)

```shell
mv /usr/local/bin/get-off-my-port /usr/local/bin/gomp
```

## Usage

To use it, simply invoke it with the port number you want freed. For example:

```shell
get-off-my-port 42
```

If you commonly need to free the same port, you can set it as the default using an environment variable and you can omit the argument.

```shell
export GET_OFF_MY_PORT_DEFAULT=42
get-off-my-port
```

## Options

*	`--info <port>`: Show the processes using that port.
*	`--force`: Kill the process without asking.
*	`--help`: Get full command details.
*	`--version`: Get the version--not that there are likely to be many.
