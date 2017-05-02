From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 2 May 2017 13:15:11 -0400
Subject: [Intel-wired-lan] e1000e echo request response latency and tcph->ack
Message-ID: <CAF=yD-+CpkwaEZeZA3UR4CLoqYQfUb-srBd-gew98=PjxTYauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With RR tests on a pair of 82571EB I am seeing much lower latency with
TCP (40 usec) vs UDP (105 usec). But only for TCP with the ACK bit
set.

I observed the initial TCP vs UDP results with sockperf.  Digging into
this behavior by emulating the protocol headers with packet sockets
show that just toggling the ACK bit changes this behavior. I shared
the test program that does this on github [1].

Is this known behavior? Is there some fast path on the NIC triggered
only for TCP ACK packets? If so, then my real question is, is there a
way to make UDP packets take this fast path?

Output:

# emulate UDP
./pingpong_tcpudp -s 192.168.2.2 -d 192.168.2.1 -S ${smac} -D {$dmac} -i eth2 -u
mode: server
1. RTT: 140 usec
2. RTT: 108 usec
3. RTT: 106 usec
4. RTT: 105 usec
5. RTT: 106 usec
6. RTT: 105 usec
7. RTT: 106 usec
8. RTT: 105 usec
9. RTT: 106 usec

# emulate TCP
./pingpong_tcpudp -s 192.168.2.2 -d 192.168.2.1 -S ${smac} -D ${dmac} -i eth2
mode: server
1. RTT: 145 usec
2. RTT: 107 usec
3. RTT: 105 usec
4. RTT: 105 usec
5. RTT: 105 usec
6. RTT: 104 usec
7. RTT: 104 usec
8. RTT: 104 usec
9. RTT: 105 usec

# emulate TCP and set ACK bit
./pingpong_tcpudp -s 192.168.2.2 -d 192.168.2.1 -S ${smac} -D ${dmac} -i eth2 -a
mode: server
1. RTT: 79 usec
2. RTT: 41 usec
3. RTT: 41 usec
4. RTT: 41 usec
5. RTT: 39 usec
6. RTT: 39 usec
7. RTT: 39 usec
8. RTT: 39 usec
9. RTT: 40 usec


The hosts are connected through a switch, so there is some chance that
this delay is incurred there. It is unlikely, as other non-e1000e
devices do not show the same latency.

The machine is running Linux at current davem-net-next/master HEAD,
booted with idle=poll.

ethtool -i eth2
driver: e1000e
version: 3.2.6-k
firmware-version: 5.11-2

Interrupt moderation, RPS and RFS are disabled and the packets are
dropped to avoid ICMP responses:

modprobe e1000e
ip link set dev eth2 up
ip addr add 192.168.2.2/24 dev eth2
for dev in eth0 eth2; do ethtool -C $dev adaptive-rx off adaptive-tx
off rx-usecs 0 rx-frames 0 tx-usecs 0 tx-frames 0; done
echo 0 > /proc/sys/net/core/rps_sock_flow_entries
echo 0 > /sys/class/net/eth2/queues/rx-0/rps_cpus
echo 0 > /sys/class/net/eth2/queues/rx-0/rps_flow_cnt
iptables -A PREROUTING -t raw -p udp --dport 4369 -j DROP
iptables -A PREROUTING -t raw -p tcp --dport 4369 -j DROP
iptables -A PREROUTING -t raw -p udp --dport 8738 -j DROP
iptables -A PREROUTING -t raw -p tcp --dport 8738 -j DROP

[1] https://github.com/wdebruij/kerneltools/blob/master/tests/pingpong_tcpudp.c
