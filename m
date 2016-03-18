From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 18 Mar 2016 20:57:20 +0800
Subject: [Intel-wired-lan] [RFC PATCH linux-next] igb: igb_update_pf_vlvf()
	can be static
In-Reply-To: <201603182037.3GXZMnJi%fengguang.wu@intel.com>
References: <201603182037.3GXZMnJi%fengguang.wu@intel.com>
Message-ID: <20160318125720.GA2651@cairo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 igb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7366d4f..04bb264 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5965,7 +5965,7 @@ static int igb_find_vlvf_entry(struct e1000_hw *hw, u32 vlan)
 	return idx;
 }
 
-void igb_update_pf_vlvf(struct igb_adapter *adapter, u32 vid)
+static void igb_update_pf_vlvf(struct igb_adapter *adapter, u32 vid)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 bits, pf_id;
