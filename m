From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 21:16:59 +0000
Subject: [Intel-wired-lan] [PATCH V2 3/5] ixgbe: Correct length check
 for	round up
In-Reply-To: <20160314180551.8397.27934.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
 <20160314180551.8397.27934.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC26@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V2 3/5] ixgbe: Correct length check for
> round up
> 
> The function ixgbe_host_interface_command actually uses a multiple of
> word sized buffer to do its business, but only checks against the actual length
> passed in. This means that on read operations it could be possible to modify
> locations beyond the length passed in.
> Change the check to round up in the same way, just to avoid any possible
> hazard.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Use round_up function instead of an open-coded one
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied.
