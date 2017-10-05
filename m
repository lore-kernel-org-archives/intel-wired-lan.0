From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 11:42:27 -0700
Subject: [Intel-wired-lan] [PATCH v2 06/13 net-next] i40e: fix comment typo
In-Reply-To: <20171005184234.21288-1-alan.brady@intel.com>
References: <20171005184234.21288-1-alan.brady@intel.com>
Message-ID: <20171005184234.21288-7-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Someone forgot a word in this comment and it's confusing without it.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c5c3645ec682..a6143b9d86db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -516,8 +516,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	}
 
 	/* Now that we've worked out everything that could be supported by the
-	 * current PHY type, get what is supported by the NVM and them to
-	 * get what is truly supported
+	 * current PHY type, get what is supported by the NVM and intersect
+	 * them to get what is truly supported
 	 */
 	i40e_phy_type_to_ethtool(pf, &e_supported,
 				 &e_advertising);
-- 
2.14.1

