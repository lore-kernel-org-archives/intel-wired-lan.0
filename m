From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:32 -0700
Subject: [Intel-wired-lan] [PATCH 15/19] fm10k: explicitly return 0 on
 success path in function
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-16-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the fm10k_handle_resume function, return 0 explicitly at the end of
the function instead of returning the err value.

This was detected by cppcheck and resolves the following style warning
produced by that tool:

[fm10k_pci.c:2768] -> [fm10k_pci.c:2787]: (warning) Identical condition
'err', second condition is always false

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 10a3b2576a3c..082e68354643 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2340,7 +2340,7 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
 	/* Restart the MAC/VLAN request queue in-case of outstanding events */
 	fm10k_macvlan_schedule(interface);
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.22.0.214.g8dca754b1e87

