From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 20 Jun 2016 09:10:37 -0700
Subject: [Intel-wired-lan] [next PTACH S38-v2 5/7] i40evf: add hyperv dev ids
In-Reply-To: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1466439039-16378-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Joshua Hay" <joshua.a.hay@intel.com>

This patch adds the Hyper-V specific VF device ids.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Change-ID: I9c4fe6d8dfd34f7f68ebc9fdae225c8768439c89
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index eac057b..b12edba 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -57,7 +57,9 @@ static const char i40evf_copyright[] =
  */
 static const struct pci_device_id i40evf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_VF_HV), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X722_VF_HV), 0},
 	/* required last entry */
 	{0, }
 };
-- 
2.4.11

