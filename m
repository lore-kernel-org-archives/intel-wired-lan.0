From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Fri, 22 Dec 2017 12:04:48 +0100
Subject: [Intel-wired-lan] Driver i40e issues changing NIC queue runtime
 under high-load
Message-ID: <20171222120448.76f07280@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Intel,

I discovered an issue with the driver i40e, when changing the number
of NIC queues, while running a high-load packet generator, and while
having an XDP program loaded.

Tested on clean latest net-next kernel at commit 0a80f0c26bf5
 - kernel 4.15.0-rc3-net-next-01003-g0a80f0c26bf5

The NIC goes into a fault state after reporting "PF reset failed, -15"
in dmesg. See below:

 i40e 0000:04:00.0: PF reset failed, -15
 i40e 0000:04:00.0: User requested queue count/HW max RSS count:  2/64
 i40e 0000:04:00.0: ignoring delete macvlan error on PF, err I40E_ERR_QUEUE_EMPTY, aq_err OK
 i40e 0000:04:00.0: PF reset failed, -15

The net_device is in a strange state, with ifconfig showing all zero
counters.  The driver ethtool stats show packets, but nothing reach
the kernel. Loading a new xdp prog also shows zero counters (thus NIC
HW must drop these packets).

The workaround is to wait for a long while, and then change the number
of queues again.
 * If it didn't work you see:
     "i40e 0000:04:00.0: PF reset failed, -15"
 * If it worked you see:
     "i40e 0000:04:00.0: User requested queue count/HW max RSS count:  6/64"

Could some Intel people take a closer look, and explain why the HW goes
into this state? (and explain why it recovers...)


Reproducer setup info:
----------------------
Running xdp program: samples/bpf/xdp1

Tested on latest net-next kernel at commit 0a80f0c26bf5, clean kernel
without any of my patches.
 - kernel 4.15.0-rc3-net-next-01003-g0a80f0c26bf5

Packet generator script: pktgen_sample04_many_flows.sh
 with 12 threads (-t12) generating arround 12 Mpps.

Command used for changing NIC queues (--set-channels|-L):

 ethtool -L i40e1 combined 2

The NIC ethtool stats report RX packets, but nothing reach the kernel:

 Show adapter(s) (i40e1) statistics (ONLY that changed!)
 Ethtool(i40e1   ) stat:    809566977 (    809,566,977) <= port.rx_bytes /sec
 Ethtool(i40e1   ) stat:     12649480 (     12,649,480) <= port.rx_size_64 /sec
 Ethtool(i40e1   ) stat:     12649479 (     12,649,479) <= port.rx_unicast /sec

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer@Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Could some people take a closer look, wh
