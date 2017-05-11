From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 11 May 2017 23:15:53 +0000
Subject: [Intel-wired-lan] [PATCH v4 14/15] igb: check for Tx
	timestamp	timeouts during watchdog
In-Reply-To: <20170503172904.9788-15-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-15-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F6E6B@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 14/15] igb: check for Tx timestamp
> timeouts during watchdog
> 
> The igb driver has logic to handle only one Tx timestamp at a time,
> using a state bit lock to avoid multiple requests at once.
> 
> It may be possible, if incredibly unlikely, that a Tx timestamp event is
> requested but never completes. Since we use an interrupt scheme to
> determine when the Tx timestamp occurred we would never clear the state
> bit in this case.
> 
> Add an igb_ptp_tx_hang() function similar to the already existing
> igb_ptp_rx_hang() function. This function runs in the watchdog routine
> and makes sure we eventually recover from this case instead of
> permanently disabling Tx timestamps.
> 
> Note: there is no currently known way to cause this without hacking the
> driver code to force it.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c |  1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c  | 29
> +++++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
