From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 21:26:58 +0000
Subject: [Intel-wired-lan] [PATCH V2 4/5] ixgbe: Clean up interface
	for	firmware commands
In-Reply-To: <20160314180557.8397.64521.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
 <20160314180557.8397.64521.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC3E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, March 14, 2016 11:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2 4/5] ixgbe: Clean up interface for
> firmware commands
> 
> Clean up the interface for issuing firmware commands to use a void * instead
> of a u32 *. This eliminates a number of casts.
> Also clean up ixgbe_host_interface_command in a few other ways,
> eliminating comparisons with 0, redundant parens and minor formatting
> issues.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   39 ++++++++++++----
> -------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   13 +++-----
>  3 files changed, 28 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied.
