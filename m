From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 12 May 2022 14:54:22 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix possible under reporting
 of ethtool Tx and Rx statistics
In-Reply-To: <20220428211142.806462-1-paul.greenwalt@intel.com>
References: <20220428211142.806462-1-paul.greenwalt@intel.com>
Message-ID: <BYAPR11MB3367AE89B6C48D29D9177E5DFCCB9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Paul Greenwalt
> Sent: Friday, April 29, 2022 2:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: fix possible under reporting of
> ethtool Tx and Rx statistics
> 
> The hardware statistics counters are not cleared during resets so the drivers
> first access is to initialize the baseline and then subsequent reads are for
> reporting the counters. The statistics counters are read during the watchdog
> subtask when the interface is up. If the baseline is not initialized before the
> interface is up, then there can be a brief window in which some traffic can be
> transmitted/received before the initial baseline reading takes place.
> 
> Directly initialize ethtool statistics in driver open so the baseline will be
> initialized when the interface is up, and any dropped packets incremented
> before the interface is up won't be reported.
> 
> Fixes: 28dc1b86f8ea9 ("ice: ignore dropped packets during init")
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
