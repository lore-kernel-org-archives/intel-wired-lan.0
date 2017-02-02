From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Feb 2017 19:17:45 +0000
Subject: [Intel-wired-lan] [next PATCH S59 2/6] i40e: fix RSS queues
 only	operating on PF0
In-Reply-To: <1485808177-6333-3-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
 <1485808177-6333-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5DAE0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, January 30, 2017 12:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S59 2/6] i40e: fix RSS queues only
> operating on PF0
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> This patch fixes the issue that RSS offloading only works on PF0 by using the
> direct register writing of the hash keys for the VFs instead of using the admin
> queue command to do so.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Change-ID: Ia02cda7dbaa23def342e8786097a2c03db6f580b
> ---
> Testing Hints: follow the steps in the HSD.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 +++--------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 ++----
>  2 files changed, 5 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


