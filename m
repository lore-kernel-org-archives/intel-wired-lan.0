From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Aug 2017 17:47:30 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: remove logically dead code
In-Reply-To: <1501150629-20305-1-git-send-email-lihong.yang@intel.com>
References: <1501150629-20305-1-git-send-email-lihong.yang@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E8FC55@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Lihong Yang
> Sent: Thursday, July 27, 2017 3:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: remove logically dead code
> 
> This patch removes the !vf condition check that cannot be true in
> i40e_ndo_set_vf_trust function
> 
> Detected by CoverityScan, CID 1397531 Logically dead code
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


