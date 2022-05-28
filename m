From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Date: Sat, 28 May 2022 20:31:21 +0800
Subject: [Intel-wired-lan] [PATCH 1/3] e1000: Fix typos in comments
In-Reply-To: <20220528123123.1851519-1-jiaqing.zhao@linux.intel.com>
References: <20220528123123.1851519-1-jiaqing.zhao@linux.intel.com>
Message-ID: <20220528123123.1851519-2-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"VLAN filter" was misspelled as "VLAN filer" in some comments.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 1042e79a1397..f8860f24ede0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -4376,7 +4376,7 @@ void e1000_rar_set(struct e1000_hw *hw, u8 *addr, u32 index)
 /**
  * e1000_write_vfta - Writes a value to the specified offset in the VLAN filter table.
  * @hw: Struct containing variables accessed by shared code
- * @offset: Offset in VLAN filer table to write
+ * @offset: Offset in VLAN filter table to write
  * @value: Value to write into VLAN filter table
  */
 void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value)
@@ -4396,7 +4396,7 @@ void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value)
 }
 
 /**
- * e1000_clear_vfta - Clears the VLAN filer table
+ * e1000_clear_vfta - Clears the VLAN filter table
  * @hw: Struct containing variables accessed by shared code
  */
 static void e1000_clear_vfta(struct e1000_hw *hw)
-- 
2.34.1

