From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 18:33:34 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/5] net-intel: avoid permanent
 lock of	*_PTP_TX_IN_PROGRESS
In-Reply-To: <20170428184421.20216-3-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
 <20170428184421.20216-3-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F11@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, April 28, 2017 11:44 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v3 2/5] net-intel: avoid permanent lock of
> *_PTP_TX_IN_PROGRESS
> 
> Several drivers share a pattern for Tx timestamping using a bit lock to indicate
> when the timestamp is in progress so that multiple packets cannot be
> timestamped at once. This is required because we only have one set of Tx
> timestamp registers. There exist a few corner cases where we were not
> properly cleaning up after ourselves on failure to transmit, which potentially
> resulted in the state bit being locked forever.
> 
> Add some code at the end of the *_xmit_frame() routines to check and
> make sure we cleanup in the case of failure. For the *_tx_map() functions,
> we also need to add a return code to indicate when DMA failure occurred.
> 
> This resolves a possible permanent lock of the PTP_TX_IN_PROGRESS bit for
> igb, ixgbe, and i40e. The e1000e driver does not have the same problem due
> to the ordering of the Tx flow.
> 
> Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 26
> ++++++++++++++++++++------
>  drivers/net/ethernet/intel/igb/igb_main.c     | 23 ++++++++++++++++++----
> -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++++++-----
>  3 files changed, 53 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


