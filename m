From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:52 -0700
Subject: [Intel-wired-lan] [PATCH 02/12] igc: Check unsupported flag in
 igc_add_mac_filter()
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The IGC_MAC_STATE_SRC_ADDR flags is not supported by igc_add_mac_
filter() so this patch adds a check for it and returns -ENOTSUPP
in case it is set.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 107e9f86bd0a..5360d73d9c63 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2201,6 +2201,8 @@ static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 
 	if (is_zero_ether_addr(addr))
 		return -EINVAL;
+	if (flags & IGC_MAC_STATE_SRC_ADDR)
+		return -ENOTSUPP;
 
 	/* Search for the first empty entry in the MAC table.
 	 * Do not touch entries at the end of the table reserved for the VF MAC
-- 
2.25.0

