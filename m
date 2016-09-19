From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Mon, 19 Sep 2016 17:00:02 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: replace defined with
	IS_ENABLED
In-Reply-To: <1473866814-21374-1-git-send-email-zyjzyj2000@gmail.com>
References: <1473866814-21374-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992506E6E4B@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
>Behalf Of zyjzyj2000 at gmail.com
>Sent: Wednesday, September 14, 2016 8:27 AM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
>Jeffrey T <jeffrey.t.kirsher@intel.com>; zyjzyj2000 at gmail.com; e1000-
>devel at lists.sourceforge.net
>Subject: [PATCH 1/1] ixgbe: replace defined with IS_ENABLED
>
>From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
>Replace defined macro with IS_ENABLED in ixgbe.h file
>
>Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>index 9475ff9..f8bc1d0 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>@@ -45,7 +45,7 @@
> #include "ixgbe_type.h"
> #include "ixgbe_common.h"
> #include "ixgbe_dcb.h"
>-#if defined(CONFIG_FCOE) || defined(CONFIG_FCOE_MODULE)
>+#if IS_ENABLED(CONFIG_FCOE)
> #define IXGBE_FCOE
> #include "ixgbe_fcoe.h"
> #endif /* CONFIG_FCOE or CONFIG_FCOE_MODULE */
>--
>2.7.4

Already taken care of by the following patch:
http://patchwork.ozlabs.org/patch/668894/

Thanks,
Emil
 
