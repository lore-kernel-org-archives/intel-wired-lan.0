From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:39 -0700
Subject: [Intel-wired-lan] [next PATCH S37 09/15] i40e: fix missing DA cable
	check
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Serey Kong <serey.kong@intel.com>

When a Direct Attach (DA) cable is used, if the i40e_set_settings
function is called it would return an error. Add the DA type so
the function won't fail.

Signed-off-by: Serey Kong <serey.kong@intel.com>
Change-ID: I2b802f27a5d91cfefa72fd1f852acb4d74647a8e
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index dce812e..0e80b35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -663,6 +663,7 @@ static int i40e_set_settings(struct net_device *netdev,
 	if (hw->phy.media_type != I40E_MEDIA_TYPE_BASET &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_FIBER &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_BACKPLANE &&
+	    hw->phy.media_type != I40E_MEDIA_TYPE_DA &&
 	    hw->phy.link_info.link_info & I40E_AQ_LINK_UP)
 		return -EOPNOTSUPP;
 
-- 
2.4.11

