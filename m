From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 19:15:59 +0000
Subject: [Intel-wired-lan] [next S97 v2 3/6] i40e: Replace strncpy with
 strlcpy to ensure null termination
In-Reply-To: <20181030175047.18874-3-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
 <20181030175047.18874-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32902A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, October 30, 2018 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Patryk Ma?ek <patryk.malek@intel.com>
> Subject: [Intel-wired-lan] [next S97 v2 3/6] i40e: Replace strncpy with strlcpy
> to ensure null termination
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> Using strncpy allows destination buffer to be not null terminated after the
> copying takes place. strlcpy ensures that's not the case by explicitly setting
> last element in the buffer as '\0'.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
> drivers/net/ethernet/intel/i40e/i40e_ptp.c  |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


