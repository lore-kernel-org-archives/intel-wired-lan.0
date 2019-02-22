From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Feb 2019 23:52:35 +0000
Subject: [Intel-wired-lan] [PATCH S12 08/14] ice: configure GLINT_ITR to
 always have an ITR gran of 2
In-Reply-To: <20190208205101.12078-9-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366B04@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 08/14] ice: configure GLINT_ITR to
> always have an ITR gran of 2
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Instead of hoping that our ITR granularity will be 2 usec program the
> GLINT_CTL register to make sure the ITR granularity is always 2 usecs.
> 
> Now that we know what the ITR granularity will be get rid of the check in
> ice_probe() to verify our previous assumption.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 10 ++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 33
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 18 --------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h       |  1 +
>  4 files changed, 44 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


