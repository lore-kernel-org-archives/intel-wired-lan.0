From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 16:26:29 +0000
Subject: [Intel-wired-lan] [next PATCH S98 2/6] i40e: always set
 ks->base.speed in i40e_get_settings_link_up
In-Reply-To: <20181026213333.51495-2-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
 <20181026213333.51495-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328F87@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 26, 2018 2:33 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S98 2/6] i40e: always set ks-
> >base.speed in i40e_get_settings_link_up
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In i40e_get_settings_link_up, set ks->base.speed to SPEED_UNKNOWN in
> the case where we don't know the link speed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


