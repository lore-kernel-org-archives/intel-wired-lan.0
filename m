From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:56 -0700
Subject: [Intel-wired-lan] [PATCH 06/12] igc: Improve address check in
 igc_del_mac_filter()
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-7-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igc_add_mac_filter() doesn't allow filters with invalid MAC address to
be added to adapter->mac_table so, in igc_del_mac_filter(), we can early
return if MAC address is invalid. No need to traverse the table.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0ca7afaf6fc7..a71f1a5ca27c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2247,7 +2247,7 @@ static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 	int rar_entries = hw->mac.rar_entry_count;
 	int i;
 
-	if (is_zero_ether_addr(addr))
+	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
 	/* Search for matching entry in the MAC table based on given address
-- 
2.25.0

