From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 20:00:03 +0000
Subject: [Intel-wired-lan] [PATCH v2 04/13] i40e/i40evf: fix
	I40E_MASK	signed shift overflow warnings
In-Reply-To: <1460588914-20143-5-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D25FC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 13, 2016 4:08 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2 04/13] i40e/i40evf: fix I40E_MASK
> signed shift overflow warnings
> 
> GCC 6 has a new warning which will display when you attempt to left shift a
> signed value beyond the storage size of the type. I40E_MASK generates a
> mask value for 32bit registers. Properly typecast the mask value and place
> the values in parenthesis to prevent macro expansion issues.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles without shift warnings with gcc6
