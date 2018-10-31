From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 21:37:17 +0000
Subject: [Intel-wired-lan] [net 2/2] i40e: enable NETIF_F_NTUPLE and
 NETIF_F_HW_TC at driver load
In-Reply-To: <20181029175243.13453-2-jacob.e.keller@intel.com>
References: <20181029175243.13453-1-jacob.e.keller@intel.com>
 <20181029175243.13453-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3291B5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, October 29, 2018 10:53 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net 2/2] i40e: enable NETIF_F_NTUPLE and
> NETIF_F_HW_TC at driver load
> 
> The assignment of the feature flag NETIF_F_NTUPLE and NETIF_F_HW_TC
> occurs prior to the initial setup of the local hw_features variable.
> 
> This means the features are set as user-changeable, but are not set in the
> currently active feature list. This results in the features being disabled at the
> driver's initial load.
> 
> Move the assignment after the initial assignment of hw_features, and assign
> to the local variable. This ensures that NETIF_F_NTUPLE and NETIF_F_HW_TC
> are marked as user-changeable, and also enables them by default when the
> driver loads.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


