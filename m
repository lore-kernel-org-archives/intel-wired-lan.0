From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jun 2019 23:21:23 +0000
Subject: [Intel-wired-lan] [net] ixgbevf: Use cached link state instead
 of re-reading the value for ethtool
In-Reply-To: <20190619165853.28234-1-jeffrey.t.kirsher@intel.com>
References: <20190619165853.28234-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3F8D63@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, June 19, 2019 9:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>; Guilherme
> Piccoli <gpiccoli@canonical.com>
> Subject: [Intel-wired-lan] [net] ixgbevf: Use cached link state instead of re-
> reading the value for ethtool
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Change the ethtool link settings call to just read the cached state out of the
> adapter structure instead of trying to recheck the value from the PF.
> Doing this should prevent excessive reading of the mailbox.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Guilherme Piccoli <gpiccoli@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


