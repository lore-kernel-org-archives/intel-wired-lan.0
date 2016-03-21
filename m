From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 21:13:34 +0000
Subject: [Intel-wired-lan] [PATCH V2 2/5] ixgbe: Change the lan_id and
 func fields to a u8 to avoid casts
In-Reply-To: <20160314180546.8397.53488.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
 <20160314180546.8397.53488.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC14@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, March 14, 2016 11:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2 2/5] ixgbe: Change the lan_id and func
> fields to a u8 to avoid casts
> 
> Since the lan_id and func fields only ever hold small values, make them u8 to
> avoid casts used to silence warnings.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied.
