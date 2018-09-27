From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Sep 2018 16:20:26 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove unnecessary print
 statement
In-Reply-To: <20180921193907.4864-1-natechancellor@gmail.com>
References: <20180921193907.4864-1-natechancellor@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC89C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Nathan Chancellor
> Sent: Friday, September 21, 2018 12:39 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev at vger.kernel.org; Nathan Chancellor
> <natechancellor@gmail.com>; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove unnecessary print
> statement
> 
> Clang warns that the address of a pointer will always evaluated as true in a
> boolean context.
> 
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:136:9: warning: address of
> array 'vsi->active_vlans' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>                  vsi->active_vlans ? "<valid>" : "<null>");
>                  ~~~~~^~~~~~~~~~~~ ~
> ./include/linux/device.h:1431:33: note: expanded from macro 'dev_info'
>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                        ^~~~~~~~~~~
> 1 warning generated.
> 
> Given that the statement shows that active_vlans is always valid, just
> remove the statement since it's not giving any useful information.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/82
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


