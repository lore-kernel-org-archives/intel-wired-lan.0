From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:31 -0700
Subject: [Intel-wired-lan] [PATCH 14/19] fm10k: remove needless
 initialization of size local variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-15-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The local variable 'size' in fm10k_dfwd_add_station is initialized, but
is always re-assigned immediately before use. Remove this unnecessary
initialization.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[fm10k_netdev.c:1466]: (style) Variable 'size' is assigned a value that is never used.

Change-Id: I6f6d1ba3b9b26c2ed6f434fbeeafbbda4b78db33
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: fm10k: remove needless initialization of size local variable
Change-type: ImplementationChange
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 4704395c0f66..d3e85480f46d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1463,7 +1463,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 	struct fm10k_l2_accel *old_l2_accel = NULL;
 	struct fm10k_dglort_cfg dglort = { 0 };
 	struct fm10k_hw *hw = &interface->hw;
-	int size = 0, i;
+	int size, i;
 	u16 vid, glort;
 
 	/* The hardware supported by fm10k only filters on the destination MAC
-- 
2.22.0.214.g8dca754b1e87

