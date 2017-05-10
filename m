From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 10 May 2017 00:57:09 +0000
Subject: [Intel-wired-lan] [PATCH v4 06/15] igb: avoid permanent lock
	of	*_PTP_TX_IN_PROGRESS
In-Reply-To: <20170503172904.9788-7-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-7-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F54BA@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 06/15] igb: avoid permanent lock of
> *_PTP_TX_IN_PROGRESS
> 
> The igb driver uses a state bit lock to avoid handling more than one Tx
> timestamp request at once. This is required because hardware is limited
> to a single set of registers for Tx timestamps.
> 
> The state bit lock is not properly cleaned up during
> igb_xmit_frame_ring() if the transmit fails such as due to DMA or TSO
> failure. In some hardware this results in blocking timestamps until the
> service task times out. In other hardware this results in a permanent
> lock of the timestamp bit because we never receive an interrupt
> indicating the timestamp occurred, since indeed the packet was never
> transmitted.
> 
> Fix this by checking for DMA and TSO errors in igb_xmit_frame_ring() and
> properly cleaning up after ourselves when these occur.
> 
> Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com> 

