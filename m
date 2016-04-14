From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 14 Apr 2016 17:19:18 -0400
Subject: [Intel-wired-lan] [next-queue PATCH v2 0/3] Add support for GSO
 partial to Intel NIC drivers
Message-ID: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

So these are the patches needed to enable tunnel segmentation offloads on
the igb, igbvf, ixgbe, and ixgbevf drivers.  In addition this patch extends
the i40e and i40evf drivers to include segmentation support for tunnels
with outer checksums.

The net performance gain for these patches are pretty significant.  In the
case of i40e a tunnel with outer checksums showed the following
improvement:
Throughput Throughput  Local Local   Result
           Units       CPU   Service Tag
                       Util  Demand
                       %
14066.29   10^6bits/s  3.49  0.651   "before"
20618.16   10^6bits/s  3.09  0.393   "after"

For ixgbe similar results were seen:
Throughput Throughput  Local  Local   Result
           Units       CPU    Service Tag
                       Util   Demand
                       %
12879.89   10^6bits/s  10.00  0.763   "before"
14286.77   10^6bits/s  5.74   0.395   "after"

These patches rely on patches that were recently added to net-next so
please make certain to pull the latest net-next before attempting to build
with these patches.

Testing Hints:
For the i40e(vf) driver it is just a matter of creating a set of tunnels with
the checksum unabled.  If using the latest net-next kernel and iproute2
build this should be the default for tunnels such as VXLAN.  Turning off
the feature "tx-gso-partial" should also turn off
"tx-gre-csum-segmentation" and "tx-udp_tnl-csum-segmentation".

For the igb(vf) and ixgbe(vf) drivers you will need to set the feature
"tx-tcp-mangle-id-segmentation" to "on" in ethtool to enable the segmentation
offload for TCPv4 inside of tunnels, otherwise only TCPv6 inside the tunnel
will be offloaded.  If "tx-gso-partial" is turned off then you should see all
of the tunnel segmentation offloads turned off including gre, gre-csum, ipip,
sit, udp_tnl, and udp_tnl-csum.

I also have some patches I have submitted to net-next that will enable
offloads for GRE tunnels over IPv6.  Once those are accepted you should be
able to test all of the tunnel types traversing over IPv4 or IPv6 as the
underlying L3.

---

Alexander Duyck (3):
      i40e/i40evf: Add support for GSO partial with UDP_TUNNEL_CSUM and GRE_CSUM
      ixgbe/ixgbevf: Add support for GSO partial
      igb/igbvf: Add support for GSO partial


 drivers/net/ethernet/intel/i40e/i40e_main.c       |   10 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |    7 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |    7 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   |   10 +
 drivers/net/ethernet/intel/igb/igb_main.c         |  137 +++++++++++-----
 drivers/net/ethernet/intel/igbvf/netdev.c         |  182 ++++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  133 ++++++++++-----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  129 +++++++++++----
 8 files changed, 411 insertions(+), 204 deletions(-)

--
