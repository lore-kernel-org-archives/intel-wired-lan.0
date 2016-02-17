From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Feb 2016 23:12:55 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: remove redundant check
	on	vsi->active_vlans
In-Reply-To: <1455407836-7188-1-git-send-email-colin.king@canonical.com>
References: <1455407836-7188-1-git-send-email-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F06B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Saturday, February 13, 2016 3:57 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: remove redundant check on vsi-
> >active_vlans
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> active_vlans is an unsigned long array, hence a null check on this array is
> superfluous and can be removed.
> 
> Detected with static analysis by smatch:
> 
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:386
>   i40e_dbg_dump_vsi_seid() warn: this array is probably
>   non-NULL. 'vsi->active_vlans'
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Warning from smatch not given with patch applied
