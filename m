From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 10 Jun 2015 10:44:20 -0700
Subject: [Intel-wired-lan] [PATCH 0/2] ixgbe: Add VXLAN offload support
Message-ID: <20150610174304.85125.18769.stgit@mdrustad-wks.jf.intel.com>
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

Mark D Rustad (2):
      ixgbe: Add support for UDP-encapsulated tx checksum offload
      ixgbe: Add support for VXLAN RX offloads


 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |   14 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  172 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |   15 +-
 4 files changed, 169 insertions(+), 38 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
