From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 31 Mar 2021 10:13:55 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix PHY type identifiers for
 2.5G and 5G adapters
Message-ID: <20210331101355.18769-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Unlike other supported adapters, 2.5G and 5G use different
PHY type identifiers for reading/writing PHY settings
and for reading link status. Introduce separate PHY
identifiers for these two operation types.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Maloszewski <michal.maloszewski@intel.com>
Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index ce626ea..78ba6b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1568,6 +1568,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
 	I40E_PHY_TYPE_2_5GBASE_T		= 0x30,
 	I40E_PHY_TYPE_5GBASE_T			= 0x31,
+	I40E_PHY_TYPE_2_5GBASE_T_LINK_STATUS	= 0x30,
+	I40E_PHY_TYPE_5GBASE_T_LINK_STATUS	= 0x31,
 	I40E_PHY_TYPE_MAX,
 	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
-- 
2.17.1

