From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:04:49 -0700
Subject: [Intel-wired-lan] [next-queue S1 5/6] i40evf: add FW version to
	ethtool info
In-Reply-To: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427256290-24231-5-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Customers reported that the firmware version information from i40evf
is unlike that of ixgbevf and was causing problems with their scripts.
To resolve this, populate the field to align with ixgbevf.

Change-ID: I9f4e24f6a76cd819bbe07087aab2b74f715ec103
Reported-by: Sourav Chatterjee <sourav.chatterjee@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index b68b731..f4e7766 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -209,7 +209,7 @@ static void i40evf_get_drvinfo(struct net_device *netdev,
 
 	strlcpy(drvinfo->driver, i40evf_driver_name, 32);
 	strlcpy(drvinfo->version, i40evf_driver_version, 32);
-
+	strlcpy(drvinfo->fw_version, "N/A", 4);
 	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
 }
 
-- 
1.9.3

