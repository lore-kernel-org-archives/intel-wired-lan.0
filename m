From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:14:40 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 07/15] ice: Fix kernel hang
 with DCB reset in CEE mode
In-Reply-To: <20190628150332.59155-7-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-7-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD143@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 07/15] ice: Fix kernel hang with DCB
> reset in CEE mode
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch fixes the set local MIB AQ call failures in the DCB rebuild path by
> setting the defaults for the ETS recommended DCB configuration. Also,
> willing bits for the DCB configuration needs to be set correctly. Resets works
> fine in IEEE mode as the ETS recommended DCB configuration is populated
> but not in CEE mode.
> Without this patch, PFR causes the kernel hang in CEE mode.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 149 +++++++++++--------
>  1 file changed, 88 insertions(+), 61 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


