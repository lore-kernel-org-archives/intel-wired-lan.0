From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:09 -0800
Subject: [Intel-wired-lan] [PATCH S55 10/14] ice: Check for bail out
 condition early
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Check for bail out condition before calling ice_aq_sff_eeprom

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d6a9fd912971..26a7be2f7193 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3958,14 +3958,14 @@ ice_get_module_eeprom(struct net_device *netdev,
 	u8 value = 0;
 	u8 page = 0;
 
-	status = ice_aq_sff_eeprom(hw, 0, addr, offset, page, 0,
-				   &value, 1, 0, NULL);
-	if (status)
-		return -EIO;
-
 	if (!ee || !ee->len || !data)
 		return -EINVAL;
 
+	status = ice_aq_sff_eeprom(hw, 0, addr, offset, page, 0, &value, 1, 0,
+				   NULL);
+	if (status)
+		return -EIO;
+
 	if (value == ICE_MODULE_TYPE_SFP)
 		is_sfp = true;
 
-- 
2.20.1

