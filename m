From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Jun 2017 14:24:10 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 09/13] i40e: Add support
 for	OEM firmware version
In-Reply-To: <20170607094313.32060-9-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAE3A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 09/13] i40e: Add support for
> OEM firmware version
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch adds support for OEM firmware version. If OEM specific adapter is
> detected ethtool reports OEM product version in firmware version string
> instead of etrack id.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 48 ++++++++++++++++++++-----
> ----
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 47
> ++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


