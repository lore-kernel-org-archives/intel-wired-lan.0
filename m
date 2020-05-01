From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:47:42 +0000
Subject: [Intel-wired-lan] [PATCH 16/19] igc: Fix NFC rule validation
In-Reply-To: <20200424201623.10971-17-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-17-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890EE318BC858D333BFAFB1BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 16/19] igc: Fix NFC rule validation
> 
> If we try to overwrite an existing rule with the same filter but
> different action, we get EEXIST error as shown below.
> 
> $ ethtool -N eth0 flow-type ether dst <MACADDR> action 1 loc 10
> $ ethtool -N eth0 flow-type ether dst <MACADDR> action 2 loc 10
> rmgr: Cannot insert RX class rule: File exists
> 
> The second command is expected to overwrite the previous rule in location
> 10 and succeed.
> 
> This patch fixes igc_ethtool_check_nfc_rule() so it also checks the
> rules location. In case they match, the rule under evaluation should not
> be considered invalid.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
