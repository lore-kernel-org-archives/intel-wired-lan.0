From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 10 May 2017 00:56:03 +0000
Subject: [Intel-wired-lan] [PATCH v4 10/15] igb: add statistic
 indicating	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-11-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-11-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F5491@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, May 3, 2017 10:29 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v4 10/15] igb: add statistic indicating
> number of skipped Tx timestamps
> 
> The igb driver can only handle one Tx timestamp request at a time.
> This means it is possible for an application timestamp request to be
> ignored.
> 
> There is no easy way for an administrator to determine if this occurred.
> Add a new statistic which tracks this, tx_hwtstamp_skipped.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         | 1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
>  drivers/net/ethernet/intel/igb/igb_main.c    | 2 ++
>  3 files changed, 4 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
