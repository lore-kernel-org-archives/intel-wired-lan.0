From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Aug 2015 15:28:03 +0000
Subject: [Intel-wired-lan] [net-next PATCH 2/2] i40e: fix 32 bit
	build	warnings
In-Reply-To: <20150814015431.3815.82403.stgit@jbrandeb-hsm1.jf.intel.com>
References: <20150814015426.3815.89257.stgit@jbrandeb-hsm1.jf.intel.com>
 <20150814015431.3815.82403.stgit@jbrandeb-hsm1.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016CA0EB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, August 13, 2015 6:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH 2/2] i40e: fix 32 bit build warnings
> 
> Sparse found some issues with 32 bit compilation, which probably should at
> least work without warning.  Not only that, but the code was wrong.
> Thanks sparse!!
> 
> And thanks to the kbuild robot zero day testing for finding this issue.
> 
> $ make ARCH=i386 M=drivers/net/ethernet/intel/i40e C=2 CF="-
> D__CHECK_ENDIAN__"
>   CHECK   drivers/net/ethernet/intel/i40e/i40e_main.c
>   include/linux/etherdevice.h:79:32: warning: restricted __be16 degrades to
> integer
>   drivers/net/ethernet/intel/i40e/i40e_main.c:7565:17: warning: shift too big
> (32) for type unsigned long
>   drivers/net/ethernet/intel/i40e/i40e_main.c:7565:17: warning: shift too big
> (42) for type unsigned long
>   drivers/net/ethernet/intel/i40e/i40e_main.c:7565:17: warning: shift too big
> (39) for type unsigned long
>   drivers/net/ethernet/intel/i40e/i40e_main.c:7565:17: warning: shift too big
> (40) for type unsigned long
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> CC: kbuild-all at 01.org
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c |    5 -----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   12 ++++++------
>  2 files changed, 6 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

In git log, code changes present in tree, 32 bit warnings mentioned do not appear, however I do see "drivers/net/ethernet/intel/i40e/i40e_debugfs.c:189:31: warning memcpy with byte count of 134696
