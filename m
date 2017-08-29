From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:33 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 04/13] i40e: redfine
	I40E_PHY_TYPE_MAX
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Since I40E_PHY_TYPE_MAX is used as an iterator, ususally combined with
some sort of bit-shifting, it should only include actual PHY types and
not error cases. Move it up in the enum declaration so that loops only
iterate across valid PHY types.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 4c85ea9..50c5a4c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1771,9 +1771,9 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
+	I40E_PHY_TYPE_MAX,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
 	I40E_PHY_TYPE_DEFAULT			= 0xFF,
-	I40E_PHY_TYPE_MAX
 };
 
 #define I40E_LINK_SPEED_100MB_SHIFT	0x1
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index ed5602f..dc6fc8b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1767,9 +1767,9 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
+	I40E_PHY_TYPE_MAX,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
 	I40E_PHY_TYPE_DEFAULT			= 0xFF,
-	I40E_PHY_TYPE_MAX
 };
 
 #define I40E_LINK_SPEED_100MB_SHIFT	0x1
-- 
2.9.4

