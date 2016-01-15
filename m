From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 14 Jan 2016 20:41:50 -0800
Subject: [Intel-wired-lan] [next PATCH 0/3] TSO and checksum fixes for i40e
Message-ID: <20160115043921.24270.62791.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to improve the performance and reliability of i40e
when it comes to performing TSO and Tx checksum offloads related to tunnels.

I have tested it with a number of combinations of v4 over v6 and v6 over v4
for VXLANs.  With this patch set I resolved a number of issues and I am now
able to perform TSO for any of them as long as the outer UDP checksum is 0.
It should also now be supported if the outer checksum is enabled in the
case of the XL722, though I cannot test it.

I was able to verify IPv6 TSO is working correctly, however it seems like
if I use VXLAN over IPv6 I am not seeing any receive checksum offloads.
I'm still trying to work out that bit but as far as I can tell I haven't
configured anything incorrectly as the receiving end is getting the frames
in the proper format.

I'll be out on vacation for the next several days so if anything comes up I
will address it on Tuesday.

Thanks.

-Alex

---

Alexander Duyck (3):
      i40e: Refactor TSO to resolve unwanted behaviors
      i40e: Refactor Tx checksum offload
      i40e: Fix build warnings when geneve is not enabled


 drivers/net/ethernet/intel/i40e/i40e_main.c |   24 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  284 ++++++++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |    1 
 3 files changed, 178 insertions(+), 131 deletions(-)

--
