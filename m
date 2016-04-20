From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 23:11:08 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
In-Reply-To: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
References: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2699@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Saturday, April 16, 2016 1:35 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
> 
> The newly added x550em_a support causes a link failure on ARM because of
> an overly long time passed into udelay():
> 
> ERROR: "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko]
> undefined!
> 
> There are multiple variants of the ixgbe_acquire_swfw_sync_*() function,
> and the other ones all use msleep(), so we can safely assume that all callers
> are allowed to sleep, which makes msleep() a better replacement than
> mdelay().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to cross-compile driver for ARM architecture without sleep errors or warnings from compiler
