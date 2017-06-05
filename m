From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Jun 2017 23:28:25 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a sleep-in-atomic bug
In-Reply-To: <1496196731-748-1-git-send-email-baijiaju1990@163.com>
References: <1496196731-748-1-git-send-email-baijiaju1990@163.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA4F3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Tuesday, May 30, 2017 7:12 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Jia-Ju Bai <baijiaju1990@163.com>; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix a sleep-in-atomic bug
> 
> The driver may sleep under a spin lock, and the function call path is:
> i40e_ndo_set_vf_port_vlan (acquire the lock by spin_lock_bh)
>   i40e_vsi_remove_pvid
>     i40e_vlan_stripping_disable
>       i40e_aq_update_vsi_params
>         i40e_asq_send_command
>           mutex_lock --> may sleep
> 
> To fixed it, the spin lock is released before "i40e_vsi_remove_pvid", and the
> lock is acquired again after this function.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


