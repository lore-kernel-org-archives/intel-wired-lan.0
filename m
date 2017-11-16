From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:38 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 0/9] ixgbe: Add
 ipsec offload
Message-ID: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a first working draft for adding IPsec offload processing support
to the ixgbe driver for the Niantic family of Intel NICs.  I'm posting
this in order to get some review comments from the Intel folks and from
anyone else interested in the XFRM/IPsec offloads.  These patches apply
to net-next 4.14-rc4.

This code is only slightly broken in that
 - it doesn't handle Tx checksums quite correctly, so it really needs to
   be disabled with "ethtool -K ethN tx off" for now
 - it doesn't even try to handle TSO correctly yet
 - it doesn't handle IPv6 traffic yet

Please feel free to post or direct email comments.  Meanwhile, I'll work
on cleaning up the remaining issues.

As is, this code does show improvements in both packet throughput
and CPU utilization.  For example, here are some quicky numbers with
single run of "iperf -c <dest>" with the ipsec offload on both ends of
a point-to-point connection, measured on a Xeon 5520:

	9.4 Gbps - normal case
	7.4 Gbps - tx csum off
	6.6 Gbps - ipsec offload on and tx csum off  (0.06 %system)
	344 Mbps - ipsec no offload and tx csum off  (6.31 %system)
	343 Mbps - ipsec no offload and tx csum on 

To set up a test case, you first need to be sure you have a recent version
of iproute2 that supports the ipsec offload tag, probably something from
ip 4.12 or newer would b e bets, tho' I think 4.9 will work.  I have a
shell script that builds up the appropriate commands for me, but here are
the resulting commands for all tcp traffic between 14.0.0.52 and 14.0.0.70:

For the left side (14.0.0.52):
  ip x p add dir out src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp tmpl \
     proto esp src 14.0.0.52 dst 14.0.0.70 spi 0x07 mode transport reqid 0x07
  ip x p add dir in src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp tmpl \
     proto esp dst 14.0.0.52 src 14.0.0.70 spi 0x07 mode transport reqid 0x07
  ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 spi 0x07 mode transport \
     reqid 0x07 replay-window 32 \
     aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
     sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp offload dev eth4 dir out
  ip x s add proto esp dst 14.0.0.52 src 14.0.0.70 spi 0x07 mode transport \
     reqid 0x07 replay-window 32 \
     aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
     sel src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp offload dev eth4 dir in
 
For the right side (14.0.0.70):
  ip x p add dir out src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp tmpl \
     proto esp src 14.0.0.70 dst 14.0.0.52 spi 0x07 mode transport reqid 0x07
  ip x p add dir in src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp tmpl \
     proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport reqid 0x07
  ip x s add proto esp src 14.0.0.70 dst 14.0.0.52 spi 0x07 mode transport \
     reqid 0x07 replay-window 32 \
     aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
     sel src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp offload dev eth4 dir out
  ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
     reqid 0x07 replay-window 32 \
     aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
     sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp offload dev eth4 dir in

In both cases, the command "ip x s flush ; ip x p flush" will clean
it all out and remove the offloads.



Shannon Nelson (9):
  ixgbe: remove undefined and conflicting bits
  ixgbe: clean up ipsec defines
  ixgbe: add the ipsec support code files
  ixgbe: add ipsec data to driver struct
  ixgbe: add ipsec offload stats
  ixgbe: add ipsec debug helpers
  ixgbe: add tx ipsec offload
  ixgbe: add the Rx ipsec offload processing
  ixgbe: add init and remove ipsec support

 drivers/net/ethernet/intel/ixgbe/Makefile        |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   43 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c |   16 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   31 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   | 1133 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h   |   80 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   59 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   27 +-
 8 files changed, 1349 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h

-- 
2.7.4

