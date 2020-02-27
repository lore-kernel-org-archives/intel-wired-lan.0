From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:14:56 -0800
Subject: [Intel-wired-lan] [PATCH S40 06/15] ice: Display Link detected via
 Ethtool in safe mode
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the "Link detected" field is not shown when the device goes
into safe mode. This is because the safe mode Ethtool ops does not set the
get_link function. Fix this by setting the safe mode Ethtool op get_link
function.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ab37dddb225b..c9c217202046 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3866,6 +3866,7 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
 	.get_regs		= ice_get_regs,
 	.get_msglevel		= ice_get_msglevel,
 	.set_msglevel		= ice_set_msglevel,
+	.get_link		= ethtool_op_get_link,
 	.get_eeprom_len		= ice_get_eeprom_len,
 	.get_eeprom		= ice_get_eeprom,
 	.get_strings		= ice_get_strings,
-- 
2.20.1

