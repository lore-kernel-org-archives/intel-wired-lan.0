From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:19 -0700
Subject: [Intel-wired-lan] [PATCH v1 08/13] igb: make igb_update_pf_vlvf
	static
In-Reply-To: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460583084-16900-9-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3d5f234c78ac..3d58b3268182 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6027,7 +6027,7 @@ static int igb_find_vlvf_entry(struct e1000_hw *hw, u32 vlan)
 	return idx;
 }
 
-void igb_update_pf_vlvf(struct igb_adapter *adapter, u32 vid)
+static void igb_update_pf_vlvf(struct igb_adapter *adapter, u32 vid)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 bits, pf_id;
-- 
2.8.1.102.ga49ec4a

