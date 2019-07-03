From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:12:37 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 04/15] ice: Restructure VFs
 initialization flows
In-Reply-To: <20190628150332.59155-4-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD113@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 04/15] ice: Restructure VFs
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
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 70 +++++++++++++------
>  2 files changed, 49 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


