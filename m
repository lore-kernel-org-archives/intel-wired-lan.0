From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Aug 2020 03:09:08 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] igc: Remove timeout check from
 ptp_tx work
In-Reply-To: <20200728233754.65747-4-andre.guedes@intel.com>
References: <20200728233754.65747-1-andre.guedes@intel.com>
 <20200728233754.65747-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289094542BAE69855E545B53BC400@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, July 28, 2020 4:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] igc: Remove timeout check from
> ptp_tx work
> 
> The tx timestamp timeout is already checked by the watchdog_task work
> which runs periodically. In addition to that, from the ptp_tx work
> perspective, if __IGC_PTP_TX_IN_PROGRESS flag is set we always want
> handle the timestamp stored in hardware and update the skb. So this
> patch removes the timeout check in igc_ptp_tx_work() function.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
