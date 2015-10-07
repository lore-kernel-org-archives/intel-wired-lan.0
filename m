From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 7 Oct 2015 14:24:10 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: re-use %*ph specifier
	to	hexdump a data
In-Reply-To: <1443777496-43299-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443777496-43299-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B6C12@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Andy Shevchenko
> Sent: Friday, October 02, 2015 2:18 AM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: Andy Shevchenko
> Subject: [Intel-wired-lan] [PATCH 1/1] i40e: re-use %*ph specifier to
> hexdump a data
> 
> Instead of using a custom approach change the code to use %*ph format
> specifier.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 22 ++++------------------
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 22 ++++------------------
>  2 files changed, 8 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
