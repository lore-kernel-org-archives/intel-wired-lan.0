From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 10 May 2017 00:56:39 +0000
Subject: [Intel-wired-lan] [PATCH v4 03/15] igb: fix race condition
	with	PTP_TX_IN_PROGRESS bits
In-Reply-To: <20170503172904.9788-4-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
 <20170503172904.9788-4-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F54A6@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 03/15] igb: fix race condition with
> PTP_TX_IN_PROGRESS bits
> 
> Hardware related to the igb driver has a limiation of only handling one
> Tx timestamp at a time. Thus, the driver uses a state bit lock to
> enforce that only one timestamp request is honored at a time.
> 
> Unfortunately this suffers from a simple race condition. The bit lock is
> not cleared until after skb_tstamp_tx() is called notifying the stack of
> a new Tx timestamp. Even a well behaved application which sends only one
> timestamp request at once and waits for a response might wake up and
> send a new packet before the bit lock is cleared. This results in
> needlessly dropping some Tx timestamp requests.
> 
> We can fix this by unlocking the state bit as soon as we read the
> Timestamp register, as this is the first point at which it is safe to
> unlock.
> 
> To avoid issues with the skb pointer, we'll use a copy of the pointer
> and set the global variable in the driver structure to NULL first. This
> ensures that the next timestamp request does not modify our local copy
> of the skb pointer.
> 
> This ensures that well behaved applications do not accidentally race
> with the unlock bit. Obviously an application which sends multiple Tx
> timestamp requests at once will still only timestamp one packet at
> a time. Unfortunately there is nothing we can do about this.
> 
> Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
