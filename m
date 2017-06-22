From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 18:32:54 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 5/9] i40e: fix odd
 formatting	and indent
In-Reply-To: <20170620221701.46765-5-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-5-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB927@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 5/9] i40e: fix odd formatting
> and indent
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The compiler warned on an oddly indented bit of code, and when
> investigating that, noted that the functions themselves had an odd flow. The
> if condition was checked, and would exclude a call to AQ, but then the aq_ret
> would be checked unconditionally which just looks really weird, and is likely
> to cause objections.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


