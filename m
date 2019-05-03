From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:38:02 +0000
Subject: [Intel-wired-lan] [next PATCH S5 05/10] i40e: Improve AQ log
 granularity
In-Reply-To: <20190424122055.27896-5-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C6BF@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Dziggel, Douglas A <douglas.a.dziggel@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 05/10] i40e: Improve AQ log
> granularity
> 
> From: Doug Dziggel <douglas.a.dziggel@intel.com>
> 
> This patch makes it possible to log only AQ descriptors, without the entire AQ
> message buffers being dumped too. It should greatly reduce kernel log size
> in cases where a full AQ dump is not needed.
> Selection is made by setting flags in hw->debug_mask.
> 
> Additionally, some debug messages that preceded an AQ dump have been
> moved to I40E_DEBUG_AQ_COMMAND class, which seems more
> appropriate.
> 
> Signed-off-by: Doug Dziggel <douglas.a.dziggel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  8 ++--
> drivers/net/ethernet/intel/i40e/i40e_common.c | 40 ++++++++++---------
>  2 files changed, 25 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


