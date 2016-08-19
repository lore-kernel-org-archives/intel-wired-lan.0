From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 21:41:22 +0000
Subject: [Intel-wired-lan] [next PATCH S43 3/3] i40evf: Open RDMA
	Client	after reset
In-Reply-To: <1471475048-25835-3-git-send-email-bimmy.pujari@intel.com>
References: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
 <1471475048-25835-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9412@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 17, 2016 4:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S43 3/3] i40evf: Open RDMA Client
> after reset
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> RDMA client is closed during the PF reset and needs to be opened again.
> Setting the flag so that RDMA client is opened in watchdog() function.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: I507b1e4cbd05528cdff68fd360ef3dcac8901263
> ---
> Testing Hints: Needs RDMA setup. Check if there is no error in opening
>                 RDMA client after PF reset.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Base driver functions normally
