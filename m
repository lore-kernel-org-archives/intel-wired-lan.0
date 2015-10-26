From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 19:40:53 +0000
Subject: [Intel-wired-lan] [next PATCH S19 10/15] i40e/i40evf: clean
	up	error messages
In-Reply-To: <1445471236-35918-11-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3F20@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 10/15] i40e/i40evf: clean up error
> messages
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Clean up and enhance error messages related to VF MAC/VLAN filters.
> Indicate which VF is having issues, and if possible indicate the MAC address
> or VLAN involved.
> 
> Also, when an error is returned from the PF driver, print useful information
> about what went wrong, for the most likely cases.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib3d15eef9e3369a78fd142948671e5fa26d921b8
> 
> ---
> Testing-hints: Add 1000 VLANS to a VF and add 1000 multicast filters to a VF
> should show most of the errors, make sure the new errors are what is
> getting printed.
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 21 +++++++++--------
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 26
> +++++++++++++++++++---
>  2 files changed, 35 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, dmesg shows updated error messages correctly.
