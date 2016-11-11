From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:39 -0800
Subject: [Intel-wired-lan] [next PATCH S54 15/15] i40evf: remove unused
	device ID
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-16-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This device ID was intended for use when running Linux VF drivers under
Hyper-V, but we have determined that it is not necessary. Since it is
unused, and will never be used, remove it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I74998ab4237db043cd400547bb54a0a5e2a37ea5
---
Testing Hints : No code change. Modinfo should not
show 37D9 as a device supported by i40evf. This is DCR 2216.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index c0fc533..3fe87e0 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -59,7 +59,6 @@ static const struct pci_device_id i40evf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF_HV), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF_HV), 0},
 	/* required last entry */
 	{0, }
 };
-- 
2.4.11

