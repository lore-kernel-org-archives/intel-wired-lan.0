From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 15 Oct 2018 21:17:26 +0000
Subject: [Intel-wired-lan] [PATCH] ice: remove an unneeded NULL check
In-Reply-To: <20181012071709.GA10212@mwanda>
References: <20181012071709.GA10212@mwanda>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30D20E@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Friday, October 12, 2018 12:17 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>
> Cc: kernel-janitors at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: remove an unneeded NULL check
> 
> We added a NULL check in commit 072f0c3db9da ("ice: Fix potential null
> pointer issues") but it causes static checker warnings.
> 
>     drivers/net/ethernet/intel/ice/ice_switch.c:2145 ice_add_to_vsi_fltr_list()
>     warn: address of 'fm_entry->fltr_info' is non-NULL
> 
> We can just remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


