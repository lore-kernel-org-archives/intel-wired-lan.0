From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Sep 2017 21:35:58 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: point wb_desc at the
 nvm_wb_desc	during i40e_read_nvm_aq
In-Reply-To: <20170901204308.4098-1-jacob.e.keller@intel.com>
References: <20170901204308.4098-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA975A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, September 1, 2017 1:43 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] i40e: point wb_desc at the nvm_wb_desc
> during i40e_read_nvm_aq
> 
> When introducing the functions to read the NVM through the AdminQ, we
> did not correctly mark the wb_desc.
> 
> Fixes: 7073f46e443e ("i40e: Add AQ commands for NVM Update for X722",
> 2015-06-05)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


