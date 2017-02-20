From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Mon, 20 Feb 2017 12:43:11 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Undo e1000e_pm_freeze
	if	__e1000_shutdown fails
In-Reply-To: <20170217124148.17130-1-chris@chris-wilson.co.uk>
References: <20170217124148.17130-1-chris@chris-wilson.co.uk>
Message-ID: <36CDDD56DDB4D44E911123902EFC26B06CE901A6@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----

>Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
>Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
>Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>Cc: Dave Ertman <davidx.m.ertman@intel.com>
>Cc: Bruce Allan <bruce.w.allan@intel.com>
>Cc: intel-wired-lan at lists.osuosl.org
>Cc: netdev at vger.kernel.org
>---
> drivers/net/ethernet/intel/e1000e/netdev.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
>b/drivers/net/ethernet/intel/e1000e/netdev.c
>index eccf1da9356b..429a5210230d 100644
>--- a/drivers/net/ethernet/intel/e1000e/netdev.c
>+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>@@ -6615,12 +6615,19 @@ static int e1000e_pm_thaw(struct device *dev)
>static int e1000e_pm_suspend(struct device *dev)  {
> 	struct pci_dev *pdev = to_pci_dev(dev);
>+	int rc;
>
> 	e1000e_flush_lpic(pdev);
>
> 	e1000e_pm_freeze(dev);
>
>-	return __e1000_shutdown(pdev, false);
>+	rc = __e1000_shutdown(pdev, false);
>+	if (rc) {
>+		e1000e_pm_thaw(dev);
>+		return rc;
>+	}
>+
>+	return 0;
> }
>
> static int e1000e_pm_resume(struct device *dev)
>--

Looks reasonable. However, can't you get the same result with fewer code lines?
-	return __e1000_shutdown(pdev, false);
+	rc = __e1000_shutdown(pdev, false);
+	if (rc)
+		e1000e_pm_thaw(dev);
+
+	return rc;
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

