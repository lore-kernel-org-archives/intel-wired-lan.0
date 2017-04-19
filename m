From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:53 -0400
Subject: [Intel-wired-lan] [next PATCH S71 04/10] i40e: remove unnecessary
	msleep() delay in i40e_free_vfs
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The delay was added because of a desire to ensure that the VF driver can
finish up removing. However, pci_disable_sriov already has its own
ssleep() call that will sleep for an entire second, so there is no
reason to add extra delay on top of this by using msleep here. In
practice, an msleep() won't have a huge impact on timing but there is no
real value in keeping it, so lets just simplify the code and remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f44affc..20850a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -47,7 +47,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 2
 #define DRV_VERSION_MINOR 1
-#define DRV_VERSION_BUILD 7
+#define DRV_VERSION_BUILD 14
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2a47a64..29f53f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1219,8 +1219,6 @@ void i40e_free_vfs(struct i40e_pf *pf)
 	else
 		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
 
-	msleep(20); /* let any messages in transit get finished up */
-
 	/* free up VF resources */
 	tmp = pf->num_alloc_vfs;
 	pf->num_alloc_vfs = 0;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5915273..3ea81bd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -46,7 +46,7 @@ static const char i40evf_driver_string[] =
 
 #define DRV_VERSION_MAJOR 2
 #define DRV_VERSION_MINOR 1
-#define DRV_VERSION_BUILD 7
+#define DRV_VERSION_BUILD 14
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.9.3

