From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:38 -0700
Subject: [Intel-wired-lan] [PATCH 15/16] ice-linux: Fix error on driver
 remove
In-Reply-To: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002339.11107-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

If the driver is unloaded when traffic is in progress, errors are
generated. Fix this by releasing qvectors and NAPI handler on remove.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ecd9cbc457d1..959506ce597d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2239,6 +2239,7 @@ static int ice_probe(struct pci_dev *pdev,
 static void ice_remove(struct pci_dev *pdev)
 {
 	struct ice_pf *pf = pci_get_drvdata(pdev);
+	int i;
 
 	if (!pf)
 		return;
@@ -2250,6 +2251,11 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	ice_vsi_release_all(pf);
 	ice_free_irq_msix_misc(pf);
+	ice_for_each_vsi(pf, i) {
+		if (!pf->vsi[i])
+			continue;
+		ice_vsi_free_q_vectors(pf->vsi[i]);
+	}
 	ice_clear_interrupt_scheme(pf);
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
-- 
2.14.3

