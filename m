From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:34:47 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 04/15] ice: Restructure VFs
 initialization flows
In-Reply-To: <20190725085541.55104-4-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E93F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 04/15] ice: Restructure VFs
> initialization flows
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch restructures how VFs are configured, and resources allocated.
> Instead of freeing resources that were never allocated, and resetting empty
> VFs that have never been created - the new flow will just allocate resources
> for number of requested VFs based on the availability.
> 
> During VFs initialization process, global interrupt is disabled, and rearmed
> after getting MSIX vectors for VFs. This allows immediate mailbox
> communications, instead of delaying it till later and VFs.
> PF communications resulted to using polling instead of actual interrupt.
> The issue manifested when creating higher number of VFs (128 VFs) per PF.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
> v4: Reduce scope of vf in ice_config_res_vfs()
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 69 +++++++++++++------
>  2 files changed, 48 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


