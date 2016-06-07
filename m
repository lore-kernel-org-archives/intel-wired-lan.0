From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 16:09:01 -0700
Subject: [Intel-wired-lan] [PATCH v2 17/18] fm10k: return proper error code
	when pci_enable_msix_range fails
In-Reply-To: <20160607230902.5457-1-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
Message-ID: <20160607230902.5457-18-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The pci_enable_msix_range() function returns a positive value of the
number of allocated vectors if it succeeds. On failure it returns
a negative error code. Return this code properly so that the error
message printed by the driver will show the actual error code instead of
being masked by -ENOMEM.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index c85fc98945fa..f72d1cae10ff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1858,7 +1858,7 @@ static int fm10k_init_msix_capability(struct fm10k_intfc *interface)
 	if (v_budget < 0) {
 		kfree(interface->msix_entries);
 		interface->msix_entries = NULL;
-		return -ENOMEM;
+		return v_budget;
 	}
 
 	/* record the number of queues available for q_vectors */
-- 
2.9.0.rc1.405.g81f467e

