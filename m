From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:50 -0700
Subject: [Intel-wired-lan] [PATCH S31 12/15] ice: print PCI link speed and
 width
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Print message to inform user of PCI link speed and width.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 58b90fc95eb3..9b9cabf31ad1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3528,6 +3528,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		ice_cfg_lldp_mib_change(&pf->hw, true);
 	}
 
+	/* print PCI link speed and width */
+	pcie_print_link_status(pf->pdev);
+
 	return 0;
 
 err_init_peer_unroll:
-- 
2.20.1

