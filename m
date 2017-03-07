From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:30:12 +0000
Subject: [Intel-wired-lan] [next PATCH S61 07/10] i40e: removed no
 longer	needed delays
In-Reply-To: <1487721348-25617-8-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401F16@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S61 07/10] i40e: removed no longer
> needed delays
> 
> Removed no longer needed delays & structs associated with them.
> At preproduction stage those delays were needed but now these delays are
> not needed.
> 
> Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


