From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:15:21 +0000
Subject: [Intel-wired-lan] [PATCH S20 08/15] ice: Check all VFs for MDD
 activity, don't disable
In-Reply-To: <20190416173052.28928-9-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39ACA8@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 08/15] ice: Check all VFs for MDD
> activity, don't disable
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Don't use the mdd_detected variable as an exit condition for this loop; the
> first VF to NOT have an MDD event will cause the loop to terminate.
> 
> Instead just look at all of the VFs, but don't disable them. This prevents
> proper release of resources if the VFs are rebooted or the VF driver
> reloaded. Instead, just log a message and call out repeat offenders.
> 
> To make it clear what we are doing, use a differently-named variable in the
> loop.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


