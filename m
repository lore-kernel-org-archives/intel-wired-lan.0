From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:01 -0700
Subject: [Intel-wired-lan] [PATCH S58 06/13] ice: print name in /proc/iomem
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver previously printed it's PCI address in
the name field for the pci resource, which when displayed
via /proc/iomem, would print the same thing twice.

It's more useful for debugging to see the driver name, as
most other modules do.

Here's a diff of before and after this change:
     99100000-991fffff : 0000:3b:00.1
   9a000000-a04fffff : PCI Bus 0000:3b
     9a000000-9bffffff : 0000:3b:00.1
-      9a000000-9bffffff : 0000:3b:00.1
+      9a000000-9bffffff : ice
     9c000000-9dffffff : 0000:3b:00.0
-      9c000000-9dffffff : 0000:3b:00.0
+      9c000000-9dffffff : ice
     9e000000-9effffff : 0000:3b:00.1
     9f000000-9fffffff : 0000:3b:00.0
     a0000000-a000ffff : 0000:3b:00.1

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0a01acae6c96..1f88faab3ada 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4020,7 +4020,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), pci_name(pdev));
+	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
 	if (err) {
 		dev_err(dev, "BAR0 I/O map error %d\n", err);
 		return err;
-- 
2.20.1

