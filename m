From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Mar 2018 23:09:40 +0000
Subject: [Intel-wired-lan] [PATCH S88 1/8] i40e: Properly check allowed
 advertisement capabilities
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C2BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 14, 2018 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sokolowski, Jan <jan.sokolowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH S88 1/8] i40e: Properly check allowed
> advertisement capabilities
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> The i40e_set_link_ksettings and i40e_get_link_ksettings use different
> codepaths to check available and supported advertisement modes. This
> creates scenarios where it's possible to set a mode that's not allowed,
> resulting in a link down.
> 
> Fix setting advertisement in i40e_set_link_ksettings by calling
> i40e_get_link_ksettings to check what modes are allowed.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


