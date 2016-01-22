From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:26:55 -0800
Subject: [Intel-wired-lan] [next PATCH v2 00/15] TSO and checksum fixes for
	i40e
Message-ID: <20160122002407.18278.95721.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to improve the performance and reliability of i40e
when it comes to performing TSO and Tx checksum offloads related to
tunnels.

I have tested it with a number of combinations of v4 over v6 and v6 over v4
for VXLANs.  With GRE I have only been able to test with v4 as the base as 
it appears that offloads are currently not supported for GRE over IPv6.
With this patch set I resolved a number of issues and I am now able to 
perform TSO for any of them as long as the outer UDP checksum is 0.  It 
should also now be supported if the outer checksum is enabled in the case 
of the XL722, though I cannot test it.

One additional item I have identified as an issue for the v2 patchset is
the fact that Rx checksums were not working for IPv6 based tunnels due to
the fact that the ports were not being registered.  From what I can tell
there was no reason for this so I have enabled IPv6 tunnels to register
their port numbers so that they can take full advantage of Rx offloads.

As far as testing this patch set I would recommend setting up a series of
tunnels between two endpointers.  For VXLAN both v4 and v6 based tunnels
can be used, with and without checksums.  For GRE a v4 tunnel can be used
with and without checksum.

---

Alexander Duyck (15):
      i40e/i40evf: Drop outer checksum offload that was not requested
      i40e/i40evf: Use u64 values instead of casting them in TSO function
      i40e/i40evf: Factor out L4 header and checksum from L3 bits in TSO path
      i40e/i40evf: Consolidate all header changes into TSO function
      i40e/i40evf: Replace header pointers with unions of pointers in Tx checksum path
      i40e/i40evf: Add support for IPv4 encapsulated in IPv6
      i40e/i40evf: Handle IPv6 extension headers in checksum offload
      i40e/i40evf: Do not write to descriptor unless we complete
      i40e/i40evf: Add exception handling for Tx checksum
      i40e/i40evf: Clean-up Rx packet checksum handling
      i40e/i40evf: Enable support for SKB_GSO_UDP_TUNNEL_CSUM
      i40e: Fix ATR in relation to tunnels
      i40e: Do not drop support for IPv6 VXLAN or GENEVE tunnels
      i40e: Update feature flags to reflect newly enabled features
      i40evf: Update feature flags to reflect newly enabled features


 drivers/net/ethernet/intel/i40e/i40e_main.c     |   30 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |  378 ++++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h     |    1 
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |  358 ++++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h   |    1 
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   23 +
 6 files changed, 422 insertions(+), 369 deletions(-)

--
