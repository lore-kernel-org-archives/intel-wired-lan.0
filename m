From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Mon, 20 Feb 2017 13:02:01 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Undo e1000e_pm_freeze if
 __e1000_shutdown fails
In-Reply-To: <36CDDD56DDB4D44E911123902EFC26B06CE901A6@HASMSX110.ger.corp.intel.com>
References: <20170217124148.17130-1-chris@chris-wilson.co.uk>
 <36CDDD56DDB4D44E911123902EFC26B06CE901A6@HASMSX110.ger.corp.intel.com>
Message-ID: <20170220130201.GI11809@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 20, 2017 at 12:43:11PM +0000, Ruinskiy, Dima wrote:
> >-----Original Message-----
> 
> >Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
> >Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
> >Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> >Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> >Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >Cc: Dave Ertman <davidx.m.ertman@intel.com>
> >Cc: Bruce Allan <bruce.w.allan@intel.com>
> >Cc: intel-wired-lan at lists.osuosl.org
> >Cc: netdev at vger.kernel.org
> >---
> > drivers/net/ethernet/intel/e1000e/netdev.c | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> >b/drivers/net/ethernet/intel/e1000e/netdev.c
> >index eccf1da9356b..429a5210230d 100644
> >--- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >@@ -6615,12 +6615,19 @@ static int e1000e_pm_thaw(struct device *dev)
> >static int e1000e_pm_suspend(struct device *dev)  {
> > 	struct pci_dev *pdev = to_pci_dev(dev);
> >+	int rc;
> >
> > 	e1000e_flush_lpic(pdev);
> >
> > 	e1000e_pm_freeze(dev);
> >
> >-	return __e1000_shutdown(pdev, false);
> >+	rc = __e1000_shutdown(pdev, false);
> >+	if (rc) {
> >+		e1000e_pm_thaw(dev);
> >+		return rc;
> >+	}
> >+
> >+	return 0;
> > }
> >
> > static int e1000e_pm_resume(struct device *dev)
> >--
> 
> Looks reasonable. However, can't you get the same result with fewer code lines?
> -	return __e1000_shutdown(pdev, false);
> +	rc = __e1000_shutdown(pdev, false);
> +	if (rc)
> +		e1000e_pm_thaw(dev);
> +
> +	return rc;

You are welcome to use whatever style is consistent with the rest of the
driver. :)
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
