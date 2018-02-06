From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:37:14 +0000
Subject: [Intel-wired-lan] [next PATCH S86 V3 8/8] i40evf: Make VF reset
 warning message more clear
In-Reply-To: <20180205111121.59468-8-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
 <20180205111121.59468-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94997D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 5, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86 V3 8/8] i40evf: Make VF reset
> warning message more clear
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> When the PF resets the VF, the VF puts out a warning message indicating
> that the VF received a reset message from the PF.
> Make this message more clear so that we do not mistakenly think that the PF
> is undergoing a reset.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


