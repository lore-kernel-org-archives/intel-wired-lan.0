From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Oct 2017 23:21:57 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove unused enum
 latency_range
In-Reply-To: <20171016235518.4831.66585.stgit@localhost6.localdomain6>
References: <20171016235518.4831.66585.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EACF6A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, October 16, 2017 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: remove unused enum
> latency_range
> 
> This enum is no longer needed after
> commit: b4ded8327fe ("ixgbe: Update adaptive ITR algorithm")
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 -------
>  1 file changed, 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


