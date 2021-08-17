From: Switzer, David <david.switzer@intel.com>
Date: Tue, 17 Aug 2021 20:29:52 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix ATR queue selection
In-Reply-To: <20210722151931.28037-1-arkadiusz.kubalewski@intel.com>
References: <20210722151931.28037-1-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB4748BEE665DE5053DE1B5572EBFE9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Arkadiusz Kubalewski
>Sent: Thursday, July 22, 2021 8:20 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix ATR queue selection
>
>Without this patch, ATR does not work. Receive/transmit uses queue
>selection based on SW DCB hashing method.
>
>If traffic classes are not configured for PF, then use netdev_pick_tx function
>for selecting queue for packet transmission.
>Instead of calling i40e_swdcb_skb_tx_hash, call netdev_pick_tx, which
>ensures that packet is transmitted/received from CPU that is running the
>application.
>
>Reproduction steps:
>1. Load i40e driver
>2. Map each MSI interrupt of i40e port for each CPU 3. Disable ntuple, enable
>ATR i.e.:
>ethtool -K $interface ntuple off
>ethtool --set-priv-flags $interface flow-director-atr 4. Run application that is
>generating traffic and is bound to a single CPU, i.e.:
>taskset -c 9 netperf -H 1.1.1.1 -t TCP_RR -l 10 5. Observe behavior:
>Application's traffic should be restricted to the CPU provided in taskset.
>
>Fixes: 821bd0c990ba ("i40e: Fix queue-to-TC mapping on Tx")
>Signed-off-by: Przemyslaw Patynowski
><przemyslawx.patynowski@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v2: Improved commit message
>---
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com> 

