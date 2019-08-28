From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:27:39 +0000
Subject: [Intel-wired-lan] [next PATCH S9 3/7] i40e: remove
 I40E_AQC_ADD_CLOUD_FILTER_OIP
In-Reply-To: <20190826181655.15106-3-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-3-alice.michael@intel.com>
Message-ID: <cf07b50d6b6c40b288f100dde39386b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 3/7] i40e: remove
> I40E_AQC_ADD_CLOUD_FILTER_OIP
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The bit 0x0001 used in the cloud filters adminq command is reserved, and is
> not actually a valid type.
> 
> The Linux driver has never used this type, and it's not clear if any driver ever
> has.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


