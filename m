From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 19:19:28 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use udelay to avoid sleeping
 while	atomic
In-Reply-To: <20160129224429.97444.23897.stgit@mdrustad-wks.jf.intel.com>
References: <20160129224429.97444.23897.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C19E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, January 29, 2016 2:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Use udelay to avoid sleeping while
> atomic
> 
> Use udelay instead of usleep_range because this can be called while a lock is
> held.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied
