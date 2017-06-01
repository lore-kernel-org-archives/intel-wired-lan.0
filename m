From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:41 -0700
Subject: [Intel-wired-lan] [PATCH 05/15] fm10k: avoid needless delay when
	loading driver
In-Reply-To: <20170601224051.6106-1-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
Message-ID: <20170601224051.6106-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we load the driver, we set the last_reset to be in the future,
which delays the initial driver reset. Additionally, the service task
isn't scheduled to run automatically until the timer runs out. This
causes a needless delay of the first reset to begin talking to the
switch manager.

We can avoid this by simply not setting last_reset and immediately
scheduling the service task while in probe. This allows the device to
wake up faster, and avoids this delay.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 80b18f2479b4..32b5ace82cad 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1800,9 +1800,6 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		netdev->vlan_features |= NETIF_F_HIGHDMA;
 	}
 
-	/* delay any future reset requests */
-	interface->last_reset = jiffies + (10 * HZ);
-
 	/* reset and initialize the hardware so it is in a known state */
 	err = hw->mac.ops.reset_hw(hw);
 	if (err) {
@@ -2079,8 +2076,9 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* enable SR-IOV after registering netdev to enforce PF/VF ordering */
 	fm10k_iov_configure(pdev, 0);
 
-	/* clear the service task disable bit to allow service task to start */
+	/* clear the service task disable bit and kick off service task */
 	clear_bit(__FM10K_SERVICE_DISABLE, interface->state);
+	fm10k_service_event_schedule(interface);
 
 	return 0;
 
-- 
2.13.0.598.gf927b9495246

