From: Switzer, David <david.switzer@intel.com>
Date: Wed, 7 Apr 2021 22:56:25 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse errors in
 i40e_txrx.c
In-Reply-To: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB474843952B9F0BDDC23FE123EB759@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Arkadiusz Kubalewski
>Sent: Friday, March 26, 2021 11:44 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse errors in i40e_txrx.c
>
>Remove error handling through pointers. Instead use plain int to return value
>from i40e_run_xdp(...).
>
>Previously:
>- sparse errors were produced during compilation:
>i40e_txrx.c:2338 i40e_run_xdp() error: (-2147483647) too low for ERR_PTR
>i40e_txrx.c:2558 i40e_clean_rx_irq() error: 'skb' dereferencing possible
>ERR_PTR()
>
>- sk_buff* was used to return value, but it has never had valid pointer to sk_buff.
>Returned value was always int handeled as a pointer.
>
>Fixes: 0c8493d90b6b ("i40e: add XDP support for pass and drop actions")
>Fixes: 2e6893123830 ("i40e: split XDP_TX tail and XDP_REDIRECT map flushing")
>Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

