From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Jun 2017 16:39:34 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
In-Reply-To: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
References: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA605@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of John Fastabend
> Sent: Monday, May 1, 2017 10:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
> changes while XDP is loaded
> 
> XDP checks to ensure the MTU is valid and LRO is disabled when it is loaded.
> But user configuration after XDP is loaded could change these and cause a
> misconfiguration.
> 
> This patch adds checks to ensure config changes are valid.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


