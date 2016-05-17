From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:23:40 +0000
Subject: [Intel-wired-lan] [next PATCH S37 02/15] i40e: add hw struct
 local	variable
In-Reply-To: <1463419605-30746-3-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D684C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 02/15] i40e: add hw struct local
> variable
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This function uses the i40e_hw struct all over the place, so why doesn't it
> keep a pointer to the struct? Add this pointer as a local variable and use it
> consistently throughout the function.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I10eb688fe40909433fcb8ac7ac891cef67445d72
> ---
> Testing Hints : No functionality change, just code simplification.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 79 +++++++++++++++--------
> ------
>  1 file changed, 41 insertions(+), 38 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
