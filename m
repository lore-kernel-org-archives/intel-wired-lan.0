From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 May 2017 22:00:04 +0000
Subject: [Intel-wired-lan] [PATCH v4 09/15] i40e: add statistic
 indicating	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-10-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-10-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA256B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 09/15] i40e: add statistic indicating
> number of skipped Tx timestamps
> 
> The i40e driver can only handle one Tx timestamp request at a time.
> This means it is possible for an application timestamp request to be ignored.
> 
> There is no easy way for an administrator to determine if this occurred.
> Add a new statistic which tracks this, tx_hwtstamp_skipped.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 1 +
>  3 files changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


