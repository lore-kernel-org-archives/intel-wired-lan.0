From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 25 Jun 2021 22:37:30 +0000
Subject: [Intel-wired-lan] [PATCH net-queue v1 2/2] igb: Fix
 user-after-free error during reset
In-Reply-To: <20210514003104.1360697-2-vinicius.gomes@intel.com>
References: <20210514003104.1360697-1-vinicius.gomes@intel.com>
 <20210514003104.1360697-2-vinicius.gomes@intel.com>
Message-ID: <SJ0PR11MB5662A51872F9209E87C30217FA069@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Thursday, May 13, 2021 5:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: erez.geva.ext at siemens.com
> Subject: [Intel-wired-lan] [PATCH net-queue v1 2/2] igb: Fix user-after-free
> error during reset
> 
> Cleans the next descriptor to watch (next_to_watch) when cleaning the TX
> ring.
> 
> Failure to do so can cause invalid memory accesses. If igc_poll() runs while
> the controller is reset this can lead to the driver try to free a skb that was
> already freed.
> 
> (The crash is harder to reproduce with the igb driver, but the same potential
> problem exists as the code is identical to igc)
> 
> Fixes: 7cc6fd4c60f2 ("igb: Don't bother clearing Tx buffer_info in
> igb_clean_tx_ring")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Reported-by: Erez Geva <erez.geva.ext@siemens.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


