From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Sep 2016 18:42:13 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Make struct i40e_stats const
In-Reply-To: <e5f6bf3aee230a9bcbca499a4288490afb6e4512.1474946199.git.joe@perches.com>
References: <e5f6bf3aee230a9bcbca499a4288490afb6e4512.1474946199.git.joe@perches.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0EFFC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joe Perches
> Sent: Monday, September 26, 2016 8:17 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Make struct i40e_stats const
> 
> Move some data to text
> 
> $ size drivers/net/ethernet/intel/i40e/i40e_ethtool.o*
>    text	   data	    bss	    dec	    hex	filename
>   25012	      0	     32	  25044	   61d4
> 	drivers/net/ethernet/intel/i40e/i40e_ethtool.o.new
>   22868	   2120	     32	  25020	   61bc
> 	drivers/net/ethernet/intel/i40e/i40e_ethtool.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool stats work as expected

