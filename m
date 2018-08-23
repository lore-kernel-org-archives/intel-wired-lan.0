From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Aug 2018 16:11:22 +0000
Subject: [Intel-wired-lan] [next PATCH S95 09/12] i40e: use correct
 length for strncpy
In-Reply-To: <20180820151233.14629-9-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EAAF4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:13 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 09/12] i40e: use correct length for
> strncpy
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Caught by gcc 8. When we provide a length for strncpy, we should not
> include the terminating null. So we must tell it one less than the size of the
> destination buffer.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


