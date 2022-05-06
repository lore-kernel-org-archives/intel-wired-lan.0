From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 6 May 2022 09:11:12 +0000
Subject: [Intel-wired-lan] [PATCH linux-firmware] ice: Update package to
 1.3.28.0
In-Reply-To: <20220429170433.7298-1-anthony.l.nguyen@intel.com>
References: <20220429170433.7298-1-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33674231F42DD52D4A04336BFCC59@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, April 29, 2022 10:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH linux-firmware] ice: Update package to
> 1.3.28.0
> 
> Update package file to 1.3.28.0 which adds support for classifying IP
> fragmented packets.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  WHENCE                                        |   4 ++--
>  .../{ice-1.3.26.0.pkg => ice-1.3.28.0.pkg}    | Bin 635256 -> 684408 bytes
>  2 files changed, 2 insertions(+), 2 deletions(-)  rename intel/ice/ddp/{ice-
> 1.3.26.0.pkg => ice-1.3.28.0.pkg} (72%)
> 
> diff --git a/WHENCE b/WHENCE
> index 56f3cea45571..4d44fafc925c 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -5992,8 +5992,8 @@ Licence: Redistributable. See LICENSE.amlogic_vdec
> for details.
> 
>  Driver: ice - Intel(R) Ethernet Connection E800 Series
> 
> -File: intel/ice/ddp/ice-1.3.26.0.pkg
> -Link: intel/ice/ddp/ice.pkg -> ice-1.3.26.0.pkg
> +File: intel/ice/ddp/ice-1.3.28.0.pkg
> +Link: intel/ice/ddp/ice.pkg -> ice-1.3.28.0.pkg
> 
>  License: Redistributable. See LICENSE.ice for details
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
