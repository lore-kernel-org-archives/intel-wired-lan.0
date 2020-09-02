From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  2 Sep 2020 08:53:45 -0700
Subject: [Intel-wired-lan] [net 4/6] ice: Fix call trace on suspend
In-Reply-To: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
Message-ID: <20200902155347.16972-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

It appears that the ice_suspend flow is missing a call to pci_save_state
and this is triggering the message "State of device not saved by
ice_suspend" and a call trace. Fix it.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c623cdf29d6b..ebec34d23865 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4531,6 +4531,7 @@ static int __maybe_unused ice_suspend(struct device *dev)
 	}
 	ice_clear_interrupt_scheme(pf);
 
+	pci_save_state(pdev);
 	pci_wake_from_d3(pdev, pf->wol_ena);
 	pci_set_power_state(pdev, PCI_D3hot);
 	return 0;
-- 
2.20.1

