From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:36:34 +0000
Subject: [Intel-wired-lan] [PATCH S12 14/14] ice: Fix issue reclaiming
 resources back to the pool after reset
In-Reply-To: <20190208205101.12078-15-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367086@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S12 14/14] ice: Fix issue reclaiming
> resources back to the pool after reset
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch fixes issue reclaiming VF resources back to the pool after reset -
> Since we only allocate HW vector for all VFs and track together with
> resources allocation for PF with ice_search_res, we need to free VFs
> resources separately, using first VF vector index to traverse the list.
> Otherwise tracker starts from the last assigned vectors list and causes
> maximum supported number of HW vectors, 1024 to be exhausted,
> depending on the number of VFs enabled, which causes a lot of unwanted
> issues, and failed to reassign vectors for VFs.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 26 +++++++++++++++++++++++--
> -
>  1 file changed, 23 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


