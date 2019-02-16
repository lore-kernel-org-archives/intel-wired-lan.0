From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 16 Feb 2019 02:54:53 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: add tracking of AF_XDP ZC
 state for each queue pair
In-Reply-To: <20190212085205.7848-3-bjorn.topel@gmail.com>
References: <20190212085205.7848-1-bjorn.topel@gmail.com>
 <20190212085205.7848-3-bjorn.topel@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641EE4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Bj?rn T?pel
> Sent: Tuesday, February 12, 2019 12:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Topel, Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; magnus.karlsson at gmail.com;
> netdev at vger.kernel.org; Sokolowski, Jan <jan.sokolowski@intel.com>
> Subject: [PATCH 2/2] i40e: add tracking of AF_XDP ZC state for each queue
> pair
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> In commit f3fef2b6e1cc ("i40e: Remove umem from VSI") a regression was
> introduced; When the VSI was reset, the setup code would try to enable
> AF_XDP ZC unconditionally (as long as there was a umem placed in the
> netdev._rx struct). Here, we add a bitmap to the VSI that tracks if a
> certain queue pair has been "zero-copy enabled" via the ndo_bpf. The
> bitmap is used in i40e_xsk_umem, and enables zero-copy if and only if
> XDP is enabled, the corresponding qid in the bitmap is set and the
> umem is non-NULL.
> 
> Fixes: f3fef2b6e1cc ("i40e: Remove umem from VSI")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  3 +++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
