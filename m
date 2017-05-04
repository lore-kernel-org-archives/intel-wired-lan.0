From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 May 2017 22:00:30 +0000
Subject: [Intel-wired-lan] [PATCH v4 12/15] i40e: use pf data
	structure	directly in i40e_ptp_rx_hang
In-Reply-To: <20170503172904.9788-13-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-13-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA257B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, May 3, 2017 10:29 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v4 12/15] i40e: use pf data structure
> directly in i40e_ptp_rx_hang
> 
> There's no reason to pass a *vsi pointer if we already have the *pf pointer in
> the only location where we call this function. Lets update the signature and
> directly pass the *pf data structure pointer.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
> drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


