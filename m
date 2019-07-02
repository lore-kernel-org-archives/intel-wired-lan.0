From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:53 -0400
Subject: [Intel-wired-lan] [next PATCH S7 3/9] i40e: Log disable-fw-lldp
 flag change by ethtool
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Slawomir Laba <slawomirx.laba@intel.com>

Add logging for disable-fw-lldp flag by ethtool. Added check
for I40E_FLAG_DISABLE_FW_LLDP and logging state in dmesg.
Without this commit there was no clear statement in dmesg
about FW LLDP state in dmesg.

Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8dac7a87834d..db3ecb8e7051 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8499,6 +8499,11 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 		dev_dbg(&pf->pdev->dev, "PFR requested\n");
 		i40e_handle_reset_warning(pf, lock_acquired);
 
+		dev_info(&pf->pdev->dev,
+			 pf->flags & I40E_FLAG_DISABLE_FW_LLDP ?
+			 "FW LLDP is disabled\n" :
+			 "FW LLDP is enabled\n");
+
 	} else if (reset_flags & BIT_ULL(__I40E_REINIT_REQUESTED)) {
 		int v;
 
-- 
2.21.0

