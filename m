From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 May 2017 21:51:55 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] ixgbevf: Resolve warnings
	for	-Wimplicit-fallthrough
In-Reply-To: <20170512183810.26185-4-anthony.l.nguyen@intel.com>
References: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
 <20170512183810.26185-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA392C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, May 12, 2017 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/4] ixgbevf: Resolve warnings for -
> Wimplicit-fallthrough
> 
> Additions to gcc 7 now warn whenever a switch statement falls through
> implicitly.  This patch adds explicit fall through comments to address the
> following warnings:
> 
> drivers/net/ethernet/intel/ixgbevf/vf.c: In function
> ?ixgbevf_get_reta_locked?:
> drivers/net/ethernet/intel/ixgbevf/vf.c:336:6: warning: this statement may
> fall through [-Wimplicit-fallthrough=]
>    if (hw->mac.type < ixgbe_mac_X550_vf)
>       ^
> drivers/net/ethernet/intel/ixgbevf/vf.c:338:2: note: here
>   default:
>   ^~~~~~~
> drivers/net/ethernet/intel/ixgbevf/vf.c: In function
> ?ixgbevf_get_rss_key_locked?:
> drivers/net/ethernet/intel/ixgbevf/vf.c:402:6: warning: this statement may
> fall through [-Wimplicit-fallthrough=]
>    if (hw->mac.type < ixgbe_mac_X550_vf)
>       ^
> drivers/net/ethernet/intel/ixgbevf/vf.c:404:2: note: here
>   default:
>   ^~~~~~~
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


