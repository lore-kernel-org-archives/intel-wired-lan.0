From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Aug 2016 17:30:44 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Indicate support for pause
 frames	in all cases
In-Reply-To: <147224811329.93893.4553600387501040526.stgit@mdrustad-wks.jf.intel.com>
References: <147224811329.93893.4553600387501040526.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAF39@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, August 26, 2016 2:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Indicate support for pause frames
> in all cases
> 
> All the MACs supported by ixgbe support pause frames, so indicate that
> support in ethtool. Also set advertising according to requested mode.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   19
> +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

