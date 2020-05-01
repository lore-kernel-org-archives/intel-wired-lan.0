From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:23:55 +0000
Subject: [Intel-wired-lan] [PATCH 08/19] igc: Refactor
 igc_ethtool_add_nfc_rule()
In-Reply-To: <20200424201623.10971-9-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-9-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28901B4BB0AE77D27DBC7424BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 08/19] igc: Refactor
> igc_ethtool_add_nfc_rule()
> 
> Current implementation of igc_ethtool_add_nfc_rule() is quite long and a
> bit convoluted so this patch does a code refactoring to improve the
> code.
> 
> Code related to NFC rule object initialization is refactored out to the
> local helper function igc_ethtool_init_nfc_rule(). Likewise, code
> related to NFC rule validation is refactored out to another local
> helper, igc_ethtool_is_nfc_rule_valid().
> 
> RX_CLS_FLOW_DISC check is removed since it is redundant. The macro is
> defined as the max value fsp->ring_cookie can have, so checking if
> fsp->ring_cookie >= adapter->num_rx_queues is already sufficient.
> 
> Finally, some log messages are improved or added, and obvious comments
> are removed.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 150 ++++++++++++-------
>  1 file changed, 92 insertions(+), 58 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
