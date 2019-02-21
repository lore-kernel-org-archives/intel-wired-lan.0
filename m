From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Feb 2019 21:51:25 +0000
Subject: [Intel-wired-lan] [PATCH S11 12/16] ice: flush tx pipe on
 disable queue timeout
In-Reply-To: <20190208205043.11975-13-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366996@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S11 12/16] ice: flush tx pipe on disable
> queue timeout
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> set the flush tx pipe flag instead of getting an EAGAIN error when FW
> timesout in processing the disable tx queue command.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 21
> +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


