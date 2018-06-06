From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:21:03 +0000
Subject: [Intel-wired-lan] [net-queue PATCH v2 2/2] ixgbe: Move ipsec
 init function to before reset call
In-Reply-To: <20180604205125.5474.54894.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
 <20180604205125.5474.54894.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C62EE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, June 4, 2018 1:51 PM
> To: shannon.nelson at oracle.com; intel-wired-lan at osuosl.org;
> andre at tomt.net
> Subject: [Intel-wired-lan] [net-queue PATCH v2 2/2] ixgbe: Move ipsec init
> function to before reset call
> 
> This patch moves the ipsec init function in ixgbe_sw_init. This way it is a bit
> more consistent with the placement of similar initialization functions and is
> placed before the reset_hw call which should allow us to clean up any link
> issues that may be introduced by the fact that we force the link up if
> somehow the device had ipsec still enabled before the driver was loaded.
> 
> In addition to the function move it is necessary to change the assignment of
> netdev->features. The easiest way to do this is to just test for the existance
> of adapter->ipsec and if it is present we set the feature bits.
> 
> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
> Reported-by: Andre Tomt <andre@tomt.net>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |    7 -------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   11 +++++++++--
>  2 files changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


