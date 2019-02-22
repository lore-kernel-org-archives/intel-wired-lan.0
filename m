From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Feb 2019 23:50:26 +0000
Subject: [Intel-wired-lan] [PATCH S12 04/14] ice: remove redundant
 variable and if condition
In-Reply-To: <20190208205101.12078-5-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366AE4@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S12 04/14] ice: remove redundant variable
> and if condition
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In ice_pf_rxq_wait we are using an unnecessary local variable and also we
> are checking if the timeout time was reached after the loop. Get rid of the
> local variable and return 0 right when we get a successful result. This makes it
> so we can return -ETIMEDOUT if we ever exit the loop because we know the
> timeout time has been hit.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


