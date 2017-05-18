From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 May 2017 22:40:13 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: fix incorrect status check
In-Reply-To: <20170517221801.15538.81934.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
 <20170517221801.15538.81934.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3B32@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, May 17, 2017 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: fix incorrect status check
> 
> Check for ret_val instead of !ret_val to allow the rest of the code to execute
> and configure the speed properly.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


