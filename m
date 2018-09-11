From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 21:59:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/4] i40e: disallow changing the
 number of descriptors when AF_XDP is on
In-Reply-To: <20180907081848.5438-5-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
 <20180907081848.5438-5-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE6E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 4/4] i40e: disallow changing the number
> of descriptors when AF_XDP is on
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> When an AF_XDP UMEM is attached to any of the Rx rings, we disallow a
> user to change the number of descriptors via e.g. "ethtool -G IFNAME".
> 
> Otherwise, the size of the stash/reuse queue can grow unbounded, which
> would result in OOM or leaking userspace buffers.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++++++-
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 22 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


