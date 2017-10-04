From: Alan Brady <alan.brady@intel.com>
Date: Wed,  4 Oct 2017 10:58:31 -0700
Subject: [Intel-wired-lan] [PATCH 05/13 net-next] i40e: fix
	i40e_phy_type_to_ethtool function header
In-Reply-To: <20171004175839.28364-1-alan.brady@intel.com>
References: <20171004175839.28364-1-alan.brady@intel.com>
Message-ID: <20171004175839.28364-6-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function header erroneously listed 'phy_types' as a parameter.  The
correct parameter is 'pf'.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f0cde09c0bd5..c5c3645ec682 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -253,7 +253,7 @@ static void i40e_partition_setting_complaint(struct i40e_pf *pf)
 
 /**
  * i40e_phy_type_to_ethtool - convert the phy_types to ethtool link modes
- * @phy_types: PHY types to convert
+ * @pf: PF struct with phy_types
  * @supported: pointer to the ethtool supported variable to fill in
  * @advertising: pointer to the ethtool advertising variable to fill in
  *
-- 
2.14.1

