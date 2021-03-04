From: Coiby Xu <coxu@redhat.com>
Date: Thu,  4 Mar 2021 10:55:41 +0800
Subject: [Intel-wired-lan] [PATCH v1 1/3] i40e: use minimal tx and rx pairs
 for kdump
In-Reply-To: <20210304025543.334912-1-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
Message-ID: <20210304025543.334912-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the number of the MSI-X vectors to 1. When MSI-X is enabled,
it's not allowed to use more TC queue pairs than MSI-X vectors
(pf->num_lan_msix) exist. Thus the number of tx and rx pairs
(vsi->num_queue_pairs) will be equal to the number of MSI-X vectors,
i.e., 1.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 353deae139f9..77bf8c392750 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/bpf.h>
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -15485,6 +15486,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_switch_setup;
 
+	/* Reduce tx and rx pairs for kdump
+	 * When MSI-X is enabled, it's not allowed to use more TC queue
+	 * pairs than MSI-X vectors (pf->num_lan_msix) exist. Thus
+	 * vsi->num_queue_pairs will be equal to pf->num_lan_msix, i.e., 1.
+	 */
+	if (is_kdump_kernel())
+		pf->num_lan_msix = 1;
+
 	pf->udp_tunnel_nic.set_port = i40e_udp_tunnel_set_port;
 	pf->udp_tunnel_nic.unset_port = i40e_udp_tunnel_unset_port;
 	pf->udp_tunnel_nic.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
-- 
2.30.1

