From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 21:57:45 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/4] i40e: clean zero-copy XDP Tx
 ring on shutdown/reset
In-Reply-To: <20180907081848.5438-2-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
 <20180907081848.5438-2-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE4E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Friday, September 7, 2018 1:19 AM
> To: ast at kernel.org; daniel at iogearbox.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org;
> jakub.kicinski at netronome.com
> Cc: netdev at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>;
> magnus.karlsson at gmail.com; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 1/4] i40e: clean zero-copy XDP Tx ring on
> shutdown/reset
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> When the zero-copy enabled XDP Tx ring is torn down, due to configuration
> changes, outstandning frames on the hardware descriptor ring are queued
> on the completion ring.
> 
> The completion ring has a back-pressure mechanism that will guarantee that
> there is sufficient space on the ring.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 +++++++----
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 30 +++++++++++++++++++
>  3 files changed, 43 insertions(+), 6 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


