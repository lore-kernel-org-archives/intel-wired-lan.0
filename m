From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 10 Mar 2017 12:22:05 -0800
Subject: [Intel-wired-lan] [next PATCH S62 6/6] i40e: remove
	FDIR_REQUIRES_REINIT driver flag
In-Reply-To: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1489177325-13156-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This flag hasn't been used since commit 1e1be8f622ee ("i40e: ATR policy
change to flush the table to clean stale ATR rules").

Lets simplify things and just remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I76279d84db8a2fd96f445b96aa413059f9256879
---
 drivers/net/ethernet/intel/i40e/i40e.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e324b6f..dcba258 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -389,7 +389,6 @@ struct i40e_pf {
 #define I40E_FLAG_MSIX_ENABLED			BIT_ULL(3)
 #define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
 #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
-#define I40E_FLAG_FDIR_REQUIRES_REINIT		BIT_ULL(8)
 #define I40E_FLAG_NEED_LINK_UPDATE		BIT_ULL(9)
 #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
 #define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
-- 
2.4.11

