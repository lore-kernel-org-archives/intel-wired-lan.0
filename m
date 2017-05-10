From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 10 May 2017 01:05:58 +0000
Subject: [Intel-wired-lan] [PATCH v4 01/15] e1000e: fix race
	condition	around skb_tstamp_tx()
In-Reply-To: <20170503172904.9788-2-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-2-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F54E3@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 01/15] e1000e: fix race condition around
> skb_tstamp_tx()
> 
> The e1000e driver and related hardware has a limitation on Tx PTP
> packets which requires we limit to timestamping a single packet at once.
> We do this by verifying that we never request a new Tx timestamp while
> we still have a tx_hwtstamp_skb pointer.
> 
> Unfortunately the driver suffers from a race condition around this. The
> tx_hwtstamp_skb pointer is not set to NULL until after skb_tstamp_tx()
> is called. This function notifies the stack and applications of a new
> timestamp. Even a well behaved application that only sends a new request
> when the first one is finished might be woken up and possibly send
> a packet before we can free the timestamp in the driver again. The
> result is that we needlessly ignore some Tx timestamp requests in this
> corner case.
> 
> Fix this by assigning the tx_hwtstamp_skb pointer prior to calling
> skb_tstamp_tx() and use a temporary pointer to hold the timestamped skb
> until that function finishes. This ensures that the application is not
> woken up until the driver is ready to begin timestamping a new packet.
> 
> This ensures that well behaved applications do not accidentally race
> with condition to skip Tx timestamps. Obviously an application which
> sends multiple Tx timestamp requests at once will still only timestamp
> one packet at a time. Unfortunately there is nothing we can do about
> this.
> 
> Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
