From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:16 -0400
Subject: [Intel-wired-lan] [next PATCH S11 10/15] i40e: Never let speed get
	set to 0 in get_settings
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ethtool, there is a possibility of speed getting set to 0
if advertise is set to 0 (which it is when autoneg is disabled).
We never want this to happen as the firmware will actually attempt
to set the speed to 0 sending link down, so add an extra check
to make sure this doesn't happen.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I62e0eeee2cbf043d8e6f5c9c9f0b92794e877f01
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 928bd5a..930369c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -666,6 +666,13 @@ static int i40e_set_settings(struct net_device *netdev,
 	    advertise & ADVERTISED_40000baseLR4_Full)
 		config.link_speed |= I40E_LINK_SPEED_40GB;
 
+	/* If speed didn't get set, set it to what it currently is.
+	 * This is needed because if advertise is 0 (as it is when autoneg
+	 * is disabled) then speed won't get set.
+	 */
+	if (!config.link_speed)
+		config.link_speed = abilities.link_speed;
+
 	if (change || (abilities.link_speed != config.link_speed)) {
 		/* copy over the rest of the abilities */
 		config.phy_type = abilities.phy_type;
-- 
1.9.3

