From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 21:58:29 +0000
Subject: [Intel-wired-lan] [PATCH v2 3/4] i40e: clean zero-copy XDP Rx
 ring on shutdown/reset
In-Reply-To: <20180907081848.5438-4-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
 <20180907081848.5438-4-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE5F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 3/4] i40e: clean zero-copy XDP Rx ring on
> shutdown/reset
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Outstanding Rx descriptors are temporarily stored on a stash/reuse queue.
> When/if the HW rings comes up again, entries from the stash are used to re-
> populate the ring.
> 
> The latter required some restructuring of the allocation scheme for the
> AF_XDP zero-copy implementation. There is now a fast, and a slow
> allocation. The "fast allocation" is used from the fast-path and obtains free
> buffers from the fill ring and the internal recycle mechanism. The "slow
> allocation" is only used in ring setup, and obtains buffers from the fill ring and
> the stash (if any).
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   4 +-
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 100 ++++++++++++++++--
>  3 files changed, 96 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


