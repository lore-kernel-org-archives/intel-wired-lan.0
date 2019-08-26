From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:55 -0700
Subject: [Intel-wired-lan] [next PATCH S9 7/7] i40e: use BIT macro to
 specify the cloud filter field flags
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The macros used to specify the cloud filter fields are intended to be
individual bits. Declare them using the BIT() macro to make their
intention a little more clear.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f1a1bd324b50..2af9f6308f84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -243,11 +243,11 @@ struct i40e_fdir_filter {
 	u32 fd_id;
 };
 
-#define I40E_CLOUD_FIELD_OMAC	0x01
-#define I40E_CLOUD_FIELD_IMAC	0x02
-#define I40E_CLOUD_FIELD_IVLAN	0x04
-#define I40E_CLOUD_FIELD_TEN_ID	0x08
-#define I40E_CLOUD_FIELD_IIP	0x10
+#define I40E_CLOUD_FIELD_OMAC		BIT(0)
+#define I40E_CLOUD_FIELD_IMAC		BIT(1)
+#define I40E_CLOUD_FIELD_IVLAN		BIT(2)
+#define I40E_CLOUD_FIELD_TEN_ID		BIT(3)
+#define I40E_CLOUD_FIELD_IIP		BIT(4)
 
 #define I40E_CLOUD_FILTER_FLAGS_OMAC	I40E_CLOUD_FIELD_OMAC
 #define I40E_CLOUD_FILTER_FLAGS_IMAC	I40E_CLOUD_FIELD_IMAC
-- 
2.21.0

