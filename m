From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Oct 2019 23:13:01 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: enable X710 support
In-Reply-To: <20191023101957.19272-1-alice.michael@intel.com>
References: <20191023101957.19272-1-alice.michael@intel.com>
Message-ID: <276b229f7a4c44c0bfa0465350bdcc05@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, October 23, 2019 3:20 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: enable X710 support
> 
> The I40E_DEV_ID_10G_BASE_T_BC device id was added previously, but was
> not enabled in all the appropriate places.  Adding it to enable it's use.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


