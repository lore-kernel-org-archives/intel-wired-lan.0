From: David Mirabito <davidm@metamako.com>
Date: Thu, 22 Jun 2017 12:14:52 +1000
Subject: [Intel-wired-lan] [PATCH v4 00/15] ptp cornercase cleanups
In-Reply-To: <20170621155343.GA1595@calimero.vinschen.de>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170621155343.GA1595@calimero.vinschen.de>
Message-ID: <CACJTkKFkJQ2Sg8PLryxy+bXis678mc19ct7uj-69Kmfn_SM7Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For what it's worth, I found that although the patches solved the case
where a tx timestamp would *never* come  (on an I354/igb), we still had to
set "tx_timestamp_timeout 750" in ptp4l.conf as there were still the
occasional case where it'd come, just a bit later than ptp4l seems to
expect. YMMV of course, but we needed both the patch and this config change
at once in order to be stable.

Note 750 was just a number that worked. It may be that a smaller number
would suffice but it seems OK for us.

Cheers,
- DavidM


On 22 June 2017 at 01:53, Corinna Vinschen <vinschen@redhat.com> wrote:

> Hi Jacob,
>
> I'm just testing this patchset on IGB as applied to the upstream
> net-next repo (4.12.0-rc5+), and the problem persists.  It seems to
> occur more seldom than without the patch, but I'm still seeing
> occasional messages along the lines of
>
>   ptp4l [1122.159]: timed out while polling for tx timestamp
>   ptp4l [1122.159]: increasing tx_timestamp_timeout may correct this
>   issue, but it is likely caused by a driver bug
>
> roughly every 10 minutes.  Other than ptp4l running, the machine is
> basically idle.  Is there something missing in net-next?
>
>
> Thanks,
> Corinna
>
>
> On May  3 10:28, Jacob Keller wrote:
> > This series contains fixes for similar corner cases in the e1000e, igb,
> > i40e, and ixgbe drivers reported by David Mirabito on the ptp4l mailing
> > list.
> >
> > The first few patches fix a race condition with skb_tstamp_tx(). The
> > next few patches ensure that we cleanup the state bit when exiting the
> > _xmit_frame_ring() function with a DMA or TSO failure. After this, we
> > add new statistic to count how many times the Tx timestamp is skipped
> > due to already outstanding requests. The final few patches add some
> > handling in the potential case where we somehow never finish a timestamp
> > request, ensuring that we don't permanently lock the Tx timestamps
> > forever in this rare case.
> >
> > Changes in v4
> > - Split the driver patches at request of Shannon Nelson
> > - Updated commit messages, but code content should be identical
> >
> > I apologize in advance, the patchworks will not track this properly
> > because I necessarily changed the commit subjects when splitting the
> > patches apart by driver.
> >
> > Jacob Keller (15):
> >   e1000e: fix race condition around skb_tstamp_tx()
> >   i40e: fix race condition with PTP_TX_IN_PROGRESS bits
> >   igb: fix race condition with PTP_TX_IN_PROGRESS bits
> >   ixgbe: fix race condition with PTP_TX_IN_PROGRESS bits
> >   i40e: avoid permanent lock of *_PTP_TX_IN_PROGRESS
> >   igb: avoid permanent lock of *_PTP_TX_IN_PROGRESS
> >   ixgbe: avoid permanent lock of *_PTP_TX_IN_PROGRESS
> >   e1000e: add statistic indicating number of skipped Tx timestamps
> >   i40e: add statistic indicating number of skipped Tx timestamps
> >   igb: add statistic indicating number of skipped Tx timestamps
> >   ixgbe: add statistic indicating number of skipped Tx timestamps
> >   i40e: use pf data structure directly in i40e_ptp_rx_hang
> >   i40e: check for Tx timestamp timeouts during watchdog
> >   igb: check for Tx timestamp timeouts during watchdog
> >   ixgbe: check for Tx timestamp timeouts during watchdog
> >
> >  drivers/net/ethernet/intel/e1000e/e1000.h        |  1 +
> >  drivers/net/ethernet/intel/e1000e/ethtool.c      |  1 +
> >  drivers/net/ethernet/intel/e1000e/netdev.c       | 27 ++++++++-----
> >  drivers/net/ethernet/intel/i40e/i40e.h           |  5 ++-
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  1 +
> >  drivers/net/ethernet/intel/i40e/i40e_main.c      |  3 +-
> >  drivers/net/ethernet/intel/i40e/i40e_ptp.c       | 48
> +++++++++++++++++++++---
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 28 +++++++++++---
> >  drivers/net/ethernet/intel/igb/igb.h             |  2 +
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c     |  1 +
> >  drivers/net/ethernet/intel/igb/igb_main.c        | 26 ++++++++++---
> >  drivers/net/ethernet/intel/igb/igb_ptp.c         | 41
> +++++++++++++++++++-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 ++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 42
> ++++++++++++++-------
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 42
> +++++++++++++++++++--
> >  16 files changed, 227 insertions(+), 46 deletions(-)
> >
> > --
> > 2.13.0.rc0.317.gcc792a6cad5a
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at lists.osuosl.org
> > http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170622/75da2d2f/attachment-0001.html>
