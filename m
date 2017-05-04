From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 May 2017 21:58:47 +0000
Subject: [Intel-wired-lan] [PATCH v4 05/15] i40e: avoid permanent lock
 of	*_PTP_TX_IN_PROGRESS
In-Reply-To: <20170503172904.9788-6-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-6-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA2559@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 05/15] i40e: avoid permanent lock of
> *_PTP_TX_IN_PROGRESS
> 
> The i40e driver uses a bit lock to indicate when a Tx timestamp is in progress
> to avoid attempting to timestamp multiple packets at once. This is required
> because hardware only has registers to handle one request at a time.
> 
> There is a corner case where we failed to cleanup the bit lock after a failed
> transmit. This can potentially result in a state bit being locked forever.
> 
> Add some cleanup code to i40e_xmit_frame_ring to check and make sure we
> cleanup incase of these failures. We also modify i40e_tx_map to return an
> error code indication DMA failure.
> 
> Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 26 ++++++++++++++++++++--
> ----
>  1 file changed, 20 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


