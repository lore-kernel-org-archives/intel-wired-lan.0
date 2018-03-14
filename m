From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Mar 2018 23:30:59 +0000
Subject: [Intel-wired-lan] [PATCH S88 5/8] i40e: Fix incorrect return
 types
In-Reply-To: <20180314181918.21582-5-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
 <20180314181918.21582-5-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C2ED@ORSMSX104.amr.corp.intel.com>
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
> Cc: Dziggel, Douglas A <douglas.a.dziggel@intel.com>
> Subject: [Intel-wired-lan] [PATCH S88 5/8] i40e: Fix incorrect return types
> 
> From: Doug Dziggel <douglas.a.dziggel@intel.com>
> 
> Fix return types from i40e_status to enum i40e_status_code.
> 
> Signed-off-by: Doug Dziggel <douglas.a.dziggel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


