From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 12 Jun 2015 14:23:37 -0700
Subject: [Intel-wired-lan] [PATCH V3 0/2] ixgbe: Add support for VXLAN RX
	offloads
Message-ID: <20150612211601.26842.30885.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

VXLAN tx checksum offload support is added for all devices and
VXLAN rx offload support, including ATR, is added for X55x devices
that support it.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---
Changes in V2:
- UDP-encapsulated tx offload should now support more than VXLAN
- no longer set NETIF_F_GSO_UDP_TUNNEL
- validate inner header offset for tx offload support
Changes in V3:
- don't clear bits that were never set
- add unlikely to a header offset check
- change __constant_htons to simply htons

---

Mark Rustad (2):
      ixgbe: Add support for UDP-encapsulated tx checksum offload
      ixgbe: Add support for VXLAN RX offloads


 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |   18 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  178 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |   15 +-
 4 files changed, 177 insertions(+), 40 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
