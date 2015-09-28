From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:33 -0400
Subject: [Intel-wired-lan] [next PATCH S16 04/15] i40e: Removed unused
	defines
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

Two defines that are not used are causing customer confusion - remove
them.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: Icef0325aca8e0f4fcdfc519e026bdd375e791200
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 736f6f0..7fe94e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -29,8 +29,6 @@
 
 #include "i40e.h"
 
-#define I40E_MAX_MACVLAN_FILTERS 256
-#define I40E_MAX_VLAN_FILTERS 256
 #define I40E_MAX_VLANID 4095
 
 #define I40E_VIRTCHNL_SUPPORTED_QTYPES 2
-- 
1.9.3

