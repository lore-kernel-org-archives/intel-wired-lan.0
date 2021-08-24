From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 24 Aug 2021 16:25:05 +0000
Subject: [Intel-wired-lan] [next-queue v4 01/13] ice: fix Tx queue
 iteration for Tx timestamp enablement
In-Reply-To: <20210824000158.1928482-2-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-2-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336796DF0021B5BEE9AB2E80FCC59@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, August 24, 2021 5:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v4 01/13] ice: fix Tx queue iteration
> for Tx timestamp enablement
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The driver accidentally copied the ice_for_each_rxq iterator when
> implementing enablement of the ptp_tx bit for the Tx rings. We still load the
> Tx rings and set the ptp_tx field, but we iterate over the count of the
> num_rxq.
> 
> If the number of Tx and Rx queues differ, this could either cause a buffer
> overrun when accessing the tx_rings list if num_txq is greater than num_rxq,
> or it could cause us to fail to enable Tx timestamps for some rings.
> 
> This was not noticed originally as we generally have the same number of Tx
> and Rx queues.
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
