From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:13:23 +0000
Subject: [Intel-wired-lan] [next PATCH S96 2/9] i40evf: Don't enable
 vlan stripping when rx offload is turned on
In-Reply-To: <20180828171609.78242-2-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB1E1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 28, 2018 10:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S96 2/9] i40evf: Don't enable vlan
> stripping when rx offload is turned on
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> With current implementation of i40evf_set_features when user sets any
> offload via ethtool we set I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING
> as a required aq which triggers driver to call i40evf_enable_vlan_stripping.
> This shouldn't take place.
> This patches fixes it by setting the flag only when vlan offload is turned on.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


