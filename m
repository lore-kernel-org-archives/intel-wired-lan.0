From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:05 -0700
Subject: [Intel-wired-lan] [PATCH 01/19] igc: Remove unused field from
 igc_nfc_filter
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 'cookie' field is not used anywhere in the code so this patch
removes it from struct igc_nfc_filter.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index b501be243536..7c92fc7703be 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -470,7 +470,6 @@ struct igc_nfc_input {
 struct igc_nfc_filter {
 	struct hlist_node nfc_node;
 	struct igc_nfc_input filter;
-	unsigned long cookie;
 	u16 sw_idx;
 	u16 action;
 };
-- 
2.26.0

