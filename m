From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 25 Jan 2016 19:31:17 -0800
Subject: [Intel-wired-lan] [next PATCH 0/3] ixgbe/i40e: Fix ATR
 functionality related to raw sockets and IPv6 extension headers
Message-ID: <20160126032616.16387.86351.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set addresses several things.

First the i40e driver was lacking extension header parsing for ATR so I
went ahead and added support via the ipv6_find_hdr call.

Second the vxlan_port code in ixgbe was a bit convoluted and needed to be
cleaned up in order to allow me to address an issue in the ATR code.

Finally the ixgbe ATR code has been generating bogus rules for a while now
when raw sockets are being used.  The last patch resolves this and cleans
up the IPv6 extended header parsing to match the approach taken for i40e.

---

Alexander Duyck (3):
      i40e: Add support for ATR w/ IPv6 extension headers
      ixgbe: Store VXLAN port number in network order
      ixgbe: Fix ATR so that it correctly handles IPv6 extension headers


 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   30 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   90 ++++++++-----------------
 3 files changed, 44 insertions(+), 84 deletions(-)

--
