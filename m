From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Date: Sat, 28 May 2022 20:31:22 +0800
Subject: [Intel-wired-lan] [PATCH 2/3] ixgb: Fix typos in comments
In-Reply-To: <20220528123123.1851519-1-jiaqing.zhao@linux.intel.com>
References: <20220528123123.1851519-1-jiaqing.zhao@linux.intel.com>
Message-ID: <20220528123123.1851519-3-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"VLAN filter" was misspelled as "VLAN filer" in some comments.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_hw.c b/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
index c8d1e815ec6b..98bd3267b99b 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
@@ -576,7 +576,7 @@ ixgb_rar_set(struct ixgb_hw *hw,
  * Writes a value to the specified offset in the VLAN filter table.
  *
  * hw - Struct containing variables accessed by shared code
- * offset - Offset in VLAN filer table to write
+ * offset - Offset in VLAN filter table to write
  * value - Value to write into VLAN filter table
  *****************************************************************************/
 void
@@ -588,7 +588,7 @@ ixgb_write_vfta(struct ixgb_hw *hw,
 }
 
 /******************************************************************************
- * Clears the VLAN filer table
+ * Clears the VLAN filter table
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-- 
2.34.1

