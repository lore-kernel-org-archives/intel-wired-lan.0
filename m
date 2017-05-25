From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 18:18:06 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e/i40evf: proper update of
 the	page_offset field
In-Reply-To: <20170515045200.27789-1-bjorn.topel@gmail.com>
References: <20170515045200.27789-1-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA40C8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Sunday, May 14, 2017 9:52 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: Topel, Bjorn <bjorn.topel@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e/i40evf: proper update of the
> page_offset field
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> In f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
> i40e_build_skb updates the page_offset field with an incorrect offset, which
> can lead to data corruption. This patch updates page_offset correctly, by
> properly setting truesize.
> 
> Note that the bug only appears on architectures where PAGE_SIZE is
> 8192 or larger.
> 
> Fixes: f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
