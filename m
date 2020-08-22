From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 21 Aug 2020 18:24:48 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] igc: Fix race condition in PTP tx
 code
In-Reply-To: <DM6PR11MB2890FFB4041BB4F13D0326A3BC400@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200728233754.65747-1-andre.guedes@intel.com>
 <20200728233754.65747-5-andre.guedes@intel.com>
 <DM6PR11MB2890FFB4041BB4F13D0326A3BC400@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <159805948887.34417.3341607631899328702@dmsimone-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff/Tony,

Quoting Brown, Aaron F (2020-08-13 20:09:42)
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Andre Guedes
> > Sent: Tuesday, July 28, 2020 4:38 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH 4/4] igc: Fix race condition in PTP tx code
> > 
> > Currently, the igc driver supports timestamping only one tx packet at a
> > time. During the transmission flow, the skb that requires hardware
> > timestamping is saved in adapter->ptp_tx_skb. Once hardware has the
> > timestamp, an interrupt is delivered, and adapter->ptp_tx_work is
> > scheduled. In igc_ptp_tx_work(), we read the timestamp register, update
> > adapter->ptp_tx_skb, and notify the network stack.
> > 
> > While the thread executing the transmission flow (the user process
> > running in kernel mode) and the thread executing ptp_tx_work don't
> > access adapter->ptp_tx_skb concurrently, there are two other places
> > where adapter->ptp_tx_skb is accessed: igc_ptp_tx_hang() and
> > igc_ptp_suspend().
> > 
> > igc_ptp_tx_hang() is executed by the adapter->watchdog_task worker
> > thread which runs periodically so it is possible we have two threads
> > accessing ptp_tx_skb at the same time. Consider the following scenario:
> > right after __IGC_PTP_TX_IN_PROGRESS is set in igc_xmit_frame_ring(),
> > igc_ptp_tx_hang() is executed. Since adapter->ptp_tx_start hasn't been
> > written yet, this is considered a timeout and adapter->ptp_tx_skb is
> > cleaned up.
> > 
> > This patch fixes the issue described above by adding the ptp_tx_lock to
> > protect access to ptp_tx_skb and ptp_tx_start fields from igc_adapter.
> > Since igc_xmit_frame_ring() called in atomic context by the networking
> > stack, ptp_tx_lock is defined as a spinlock.
> > 
> > With the introduction of the ptp_tx_lock, the __IGC_PTP_TX_IN_PROGRESS
> > flag doesn't provide much of a use anymore so this patch gets rid of it.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc.h      |  5 ++-
> >  drivers/net/ethernet/intel/igc/igc_main.c |  7 +++-
> >  drivers/net/ethernet/intel/igc/igc_ptp.c  | 49 ++++++++++++++---------
> >  3 files changed, 40 insertions(+), 21 deletions(-)
> > 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Please hold this patch back. I think I found an issue with it. I'm
investigating it and should send a v2 soon.

Cheers,
Andre
