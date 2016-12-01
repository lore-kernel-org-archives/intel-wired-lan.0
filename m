From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 19:46:15 +0000
Subject: [Intel-wired-lan] [next PATCH S55 08/14] i40evf: fix client
 warnings
In-Reply-To: <1480377971-23412-9-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38F4D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Latif, Faisal <faisal.latif@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S55 08/14] i40evf: fix client warnings
> 
> From: Faisal Latif <faisal.latif@intel.com>
> 
> The function prototype in i40evf_client.h are giving warnings while compiling
> i40iwvf module. Move these function prototypes to i40evf.h.
> Also fix return code from u32 to int and this return code is consistent with
> i40e_client.h
> 
> Signed-off-by: Faisal Latif <faisal.latif@intel.com>
> Change-Id: Ie3757f844993aabc27654aaf02ec14fb985ad2c4
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


