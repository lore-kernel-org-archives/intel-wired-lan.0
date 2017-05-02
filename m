From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 18:32:45 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/5] net-intel: fix race condition
 with	PTP_TX_IN_PROGRESS bits
In-Reply-To: <20170428184421.20216-2-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
 <20170428184421.20216-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F01@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 1/5] net-intel: fix race condition with
> PTP_TX_IN_PROGRESS bits
> 
> Several Intel drivers have a hardware limitation on Tx PTP packets which
> requires them to limit to a single Tx timestamp at once. THey do this mostly
> using a state bit lock which enforces that only one timestamp request is
> honored at a time.
> 
> Unfortunately they all suffer from a similar race condition. The bit lock is not
> cleared until after skb_tstamp_tx() is called notifying applications of a new Tx
> timestamp. Even a well behaved application sending only one packet at a
> time and waiting for a response can wake up and send a new packet before
> the bit lock is cleared. This results in needlessly dropping some Tx timestamp
> requests.
> 
> We can fix this by unlocking the state bit as soon as we read the Timestamp
> register, as this is the first point at which it is safe to unlock.
> 
> To avoid issues with the skb pointer, we'll use a copy of the pointer and set
> the global variable in the driver structure to NULL first. This ensures that the
> next timestamp request does not modify our local copy of the skb pointer.
> 
> This ensures that well behaved applications do not accidentally race with the
> unlock bit. Obviously an application which sends multiple Tx timestamp
> requests at once will still only timestamp one packet at a time. Unfortunately
> there is nothing we can do about this.
> 
> Since the fix is almost the same for each driver, this patch combines the fixes
> for e1000e, igb, ixgbe and i40e.
> 
> Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 10 ++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c   | 14 +++++++++++---
>  drivers/net/ethernet/intel/igb/igb_ptp.c     | 12 ++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 15 ++++++++++++---
>  4 files changed, 41 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


