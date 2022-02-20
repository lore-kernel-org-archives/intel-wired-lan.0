From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Sun, 20 Feb 2022 11:41:26 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net] ice: avoid XDP checks in
 ice_clean_tx_irq()
In-Reply-To: <20220203121651.18937-1-maciej.fijalkowski@intel.com>
References: <20220203121651.18937-1-maciej.fijalkowski@intel.com>
Message-ID: <CY4PR11MB179787D32441208BE9D4B5D9F1399@CY4PR11MB1797.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, February 3, 2022 5:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net] ice: avoid XDP checks in
> ice_clean_tx_irq()
> 
> Commit 9610bd988df9 ("ice: optimize XDP_TX workloads") introduced Tx IRQ
> cleaning routine dedicated for XDP rings. Currently it is impossible to call
> ice_clean_tx_irq() against XDP ring, so it is safe to drop
> ice_ring_is_xdp() calls in there.
> 
> Fixes: 1c96c16858ba ("ice: update to newer kernel API")
> Fixes: cc14db11c8a4 ("ice: use prefetch methods")
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> 
> v2: fix commit msg and collect ack (Alex)
> 
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
