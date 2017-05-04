From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 May 2017 22:00:58 +0000
Subject: [Intel-wired-lan] [PATCH v4 13/15] i40e: check for Tx
	timestamp	timeouts during watchdog
In-Reply-To: <20170503172904.9788-14-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-14-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA2587@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 13/15] i40e: check for Tx timestamp
> timeouts during watchdog
> 
> The i40e driver has logic to handle only one Tx timestamp at a time, using a
> state bit lock to avoid multiple requests at once.
> 
> It may be possible, if incredibly unlikely, that a Tx timestamp event is
> requested but never completes. Since we use an interrupt scheme to
> determine when the Tx timestamp occurred we would never clear the state
> bit in this case.
> 
> Add an i40e_ptp_tx_hang() function similar to the already existing
> i40e_ptp_rx_hang() function. This function runs in the watchdog routine and
> makes sure we eventually recover from this case instead of permanently
> disabling Tx timestamps.
> 
> Note: there is no currently known way to cause this without hacking the
> driver code to force it.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
> drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 30
> +++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  1 +
>  4 files changed, 34 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


