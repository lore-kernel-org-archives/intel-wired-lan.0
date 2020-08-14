From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Aug 2020 03:08:47 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Don't reschedule ptp_tx work
In-Reply-To: <20200728233754.65747-3-andre.guedes@intel.com>
References: <20200728233754.65747-1-andre.guedes@intel.com>
 <20200728233754.65747-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289000597720FD7185422F72BC400@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, July 28, 2020 4:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/4] igc: Don't reschedule ptp_tx work
> 
> The ptp_tx work is scheduled only if TSICR.TXTS bit is set, therefore
> TSYNCTXCTL.TXTT_0 bit is expected to be set when we check it igc_ptp_tx_
> work(). If it isn't, something is really off and rescheduling the ptp_tx
> work to check it later doesn't help much. This patch changes the code to
> WARN_ON_ONCE() if this situation ever happens.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
