From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 18:51:01 +0000
Subject: [Intel-wired-lan] [next PATCH S12 07/15] i40e: add more
	verbose	error messages
In-Reply-To: <1440690163-128213-8-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5DB3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 07/15] i40e: add more verbose
> error messages
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Under certain circumstances, the device may not have enough resources to
> enable all of the VFs that it advertises in config space. Although the number
> of supported VFs is reported upon driver init, it is not obvious when this is
> different from the number reported in config space. To eliminate this
> confusion, add an error message explaining the problem.
> Additionally, move the 'Allocating VFs' message down below the error checks
> so as to prevent further confusion.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I45b7efca53a7aebf7777be33a8bc9d615ae48ea1
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, behaves as expected per Mitch
