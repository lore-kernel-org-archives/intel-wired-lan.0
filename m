From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Jan 2017 23:26:27 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove pr_cont uses
In-Reply-To: <7be510fd79f67969fc03be24dea68b9f198e486b.1483457249.git.joe@perches.com>
References: <7be510fd79f67969fc03be24dea68b9f198e486b.1483457249.git.joe@perches.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA589E0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joe Perches
> Sent: Tuesday, January 03, 2017 7:28 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove pr_cont uses
> 
> As pr_cont output can be interleaved by other processes, using pr_cont
> should be avoided where possible.
> 
> Miscellanea:
> 
> o Use a temporary pointer to hold the next descriptions and
>   consolidate the pr_cont uses
> o Use the temporary buffer to hold the 8 u32 register values and
>   emit those in a single go
> o Coalesce formats and logging neatening around those changes o Fix a
> defective output for the rx ring entry description when
>   also emitting rx_buffer_info data
> 
> This reduces overall object size a tiny bit too.
> 
> $ size drivers/net/ethernet/intel/ixgbe/*.o*
>    text	   data	    bss	    dec	    hex	filename
>   62167	    728	     12	  62907	   f5bb
> 	drivers/net/ethernet/intel/ixgbe/ixgbe_main.o.new
>   62273	    728	     12	  63013	   f625
> 	drivers/net/ethernet/intel/ixgbe/ixgbe_main.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 84 +++++++++++++++-----
> -------
>  1 file changed, 47 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


