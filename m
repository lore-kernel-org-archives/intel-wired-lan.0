From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 16 Feb 2019 02:54:19 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: move i40e_xsk_umem function
In-Reply-To: <20190212085205.7848-2-bjorn.topel@gmail.com>
References: <20190212085205.7848-1-bjorn.topel@gmail.com>
 <20190212085205.7848-2-bjorn.topel@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641ECE@ORSMSX101.amr.corp.intel.com>
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
> Subject: [PATCH 1/2] i40e: move i40e_xsk_umem function
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The i40e_xsk_umem function was explicitly inlined in i40e.h. There is
> no reason for that, so move it to i40e_main.c instead.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 14 --------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

