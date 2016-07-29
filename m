From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 13:59:35 +0000
Subject: [Intel-wired-lan] [PATCH -next] i40e: Use list_move instead
	of	list_del/list_add
In-Reply-To: <1469545110-32553-1-git-send-email-weiyj.lk@gmail.com>
References: <1469545110-32553-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB85E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Wei Yongjun
> Sent: Tuesday, July 26, 2016 7:59 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Wei Yongjun <weiyj.lk@gmail.com>;
> netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH -next] i40e: Use list_move instead of
> list_del/list_add
> 
> Using list_move() instead of list_del() + list_add().
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
