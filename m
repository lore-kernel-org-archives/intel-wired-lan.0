From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 18:51:57 +0000
Subject: [Intel-wired-lan] [next PATCH v2 1/2] i40evf: fix overlong
	BIT	defines
In-Reply-To: <1442455270-6681-2-git-send-email-jesse.brandeburg@intel.com>
References: <1442455270-6681-1-git-send-email-jesse.brandeburg@intel.com>
 <1442455270-6681-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3132@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Wednesday, September 16, 2015 7:01 PM
> To: e1000-patches at isotope.jf.intel.com
> Subject: [Intel-wired-lan] [next PATCH v2 1/2] i40evf: fix overlong BIT defines
> 
> The defines from the RSS enabling call were mistakenly missed in the patches
> to the i40e which should have been to i40evf as well.
> 
> this is a follow up to (commit ed921559886dd40528) "fix
> 32 bit build warnings".
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c |  5 -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 14 +++++++-------
>  2 files changed, 7 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied

