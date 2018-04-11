From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 11 Apr 2018 20:54:50 +0000
Subject: [Intel-wired-lan] [PATCH] intel: i40evf: Replace GFP_ATOMIC
 with GFP_KERNEL in i40evf_add_vlan
In-Reply-To: <1523412498-2177-1-git-send-email-baijiaju1990@gmail.com>
References: <1523412498-2177-1-git-send-email-baijiaju1990@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A964806@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Tuesday, April 10, 2018 7:08 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] intel: i40evf: Replace GFP_ATOMIC with
> GFP_KERNEL in i40evf_add_vlan
> 
> i40evf_add_vlan() is never called in atomic context.
> 
> i40evf_add_vlan() is only called by i40evf_vlan_rx_add_vid(), which is only
> set as ".ndo_vlan_rx_add_vid" in struct net_device_ops.
> ".ndo_vlan_rx_add_vid" is not called in atomic context.
> 
> Despite never getting called from atomic context,
> i40evf_add_vlan() calls kzalloc() with GFP_ATOMIC, which does not sleep for
> allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL, which
> can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


