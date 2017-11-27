From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Nov 2017 23:12:32 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant setting of
 xcast_mode
In-Reply-To: <20171121235827.20363.89.stgit@localhost6.localdomain6>
References: <20171121235827.20363.89.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF905@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, November 21, 2017 3:58 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant setting of
> xcast_mode
> 
> Removed leftover assignment of xcast_mode.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


