From: =?unknown-8bit?b?0KHQstC10YfQutCw0YDQtdCyINCd0LjQutC+0LvQsNC5?= <nsvechkarev@gazprom-media.tech>
Date: Wed, 10 Jan 2018 08:20:03 +0000
Subject: [Intel-wired-lan] PROBLEM: Uneven load distribution between bonded
 interfaces during peak load
Message-ID: <D7B04AEA27377C4D8A3483B9A43292A014FFB9CC@ex01.rutube.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

PROBLEM: Uneven load distribution between bonded interfaces during peak load

We have encountered strange behaviour on part of the network subsystem on our servers. We have a number of machines serving primarily as nginx cache servers with 5 two-port 10G NICs (100G in total). All interfaces are aggregated into a single bond. The IXGBE driver is configured so that interrupts from every interface are distributed to several dedicated CPU cores. If the bond interface is configured with mode=802.3ad and xmit_hash_policy=layer3+4, which is convenient due to the specifics of our network administration, at peak load (around 70Gbit per server on average) the distribution of traffic between bonded interfaces, as well as of interrupts between CPU cores, rapidly becomes uneven (as demonstrated by fig. 1) and stays that way until the load drops to more manageable levels. If the bond is configured to use round-robin (mode=balance-rr) instead, this problem does not occur, as demonstrated by the same machine on fig. 2.

------------------------------------------------------------
sysctl.conf

kernel.sysrq=0
kernel.core_uses_pid=1
kernel.msgmnb=65536
kernel.msgmax=65536
kernel.shmmax=68719476736
kernel.shmall=4294967296
net.ipv4.ip_forward=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.default.accept_source_route=0
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_syn_retries=2
net.ipv4.tcp_synack_retries=2
net.ipv4.tcp_fin_timeout=15
net.ipv4.tcp_keepalive_time=60
net.ipv4.tcp_keepalive_intvl=10
net.ipv4.tcp_keepalive_probes=2
net.ipv4.tcp_window_scaling=1
net.ipv4.tcp_sack=1
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_rmem=4096 87380 67108864
net.ipv4.tcp_wmem=4096 65536 67108864
net.core.somaxconn=16384
net.core.rmem_max=134217728
net.core.wmem_max=134217728
net.core.rmem_default=134217728
net.core.wmem_default=134217728
net.core.optmem_max=134217728
net.core.netdev_max_backlog=250000
net.ipv4.tcp_orphan_retries=1
net.ipv4.tcp_low_latency=1
net.ipv4.tcp_congestion_control=bbr
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
vm.swappiness=10
vm.zone_reclaim_mode=1
vm.min_free_kbytes=524288
vm.dirty_ratio=15
vm.dirty_background_ratio=5
vm.dirty_expire_centisecs=1500
net.core.default_qdisc=fq
vm.dirty_writeback_centisecs=250

------------------------------------------------------------

ixgbe.conf

options ixgbe RSS=7,7,7,7,7,7,7,7,8,8
options ixgbe LRO=1,1,1,1,1,1,1,1,1,1
options ixgbe FCoE=0,0,0,0,0,0,0,0,0,0
options ixgbe InterruptThrottleRate=1,1,1,1,1,1,1,1,1,1
options ixgbe allow_unsupported_sfp=1,1,1,1,1,1,1,1,1,1

------------------------------------------------------------
nginx version: nginx/1.12.1

------------------------------------------------------------
Linux 4.9.58-1.1.x86_64

------------------------------------------------------------
Ethernet controller: Intel(R) 82599 10 Gigabit Dual Port Network Connection (rev 01)
Subsystem: Intel(R) Ethernet Server Adapter X520-2

Intel(R) 10GbE PCI Express Linux Network Driver
version:        5.2.4
090E0631E91946938A7CC74

------------------------------------------------------------
Former bond conf:

DEVICE=bond0
IPADDR=194.190.77.137
NETMASK=255.255.255.192
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
BONDING_OPTS="miimon=1000 mode=802.3ad xmit_hash_policy=layer3+4"

New bond conf:

DEVICE=bond0
IPADDR=194.190.77.137
NETMASK=255.255.255.192
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
BONDING_OPTS="miimon=1000 mode=balance-rr"

------------------------------------------------------------
Hardware:

Supermicro CSE-216BE1C
Motherboards Board X10DRi (Intel? C612 chipset)
CPU: Intel Xeon E5-2697v4 (45M Cache, 2.30 GHz) x2
RAM: Kingston KVR24R17D4/32 (32GB 2Rx4 4G x 72-Bit PC4-2400 CL17 Registered w/Parity 288-Pin DIMM) x8
HDD: SAMSUNG MZ7LM960HMJP-00005 960 GB x2
Intel X520-DA2    x5
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180110/1201e827/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: figure1.png
Type: image/png
Size: 91052 bytes
Desc: figure1.png
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180110/1201e827/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: figure2.png
Type: image/png
Size: 87316 bytes
Desc: figure2.png
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180110/1201e827/attachment-0003.png>
