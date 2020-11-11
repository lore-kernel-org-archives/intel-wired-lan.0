From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 11 Nov 2020 13:52:07 +0800
Subject: [Intel-wired-lan] [PATCH 4/4][RFC] e1000e: Disable the power
 management if hardware error detected during resume
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Message-ID: <7eb46aa2f49f6c7a2ff0d6cc65ad4195781ae960.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the hardware error is detected during resume, the NIC might
be in a unstable status and blocks the subsequent suspend afterwards.
A broken device is not expected to impact the system wide suspend, and
this patch disable the power management support of this NIC. So that
the borken NIC will not be considered during suspend/resume, thus not
to prevent the system from suspend/resume.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205015
Reported-by: "Brandt, Todd E" <todd.e.brandt@intel.com>
Reported-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 45e0b1901440..08bc544e879a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6959,7 +6959,8 @@ static int __e1000_resume(struct pci_dev *pdev)
 		ew32(WUS, ~0);
 	}
 
-	e1000e_reset(adapter);
+	if (_e1000e_reset(adapter))
+		schedule_work(&adapter->pm_remove_task);
 
 	e1000_init_manageability_pt(adapter);
 
-- 
2.17.1

