From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:29:50 +0000
Subject: [Intel-wired-lan] [PATCH 11/19] igc: Fix NFC rule overwrite
 cases
In-Reply-To: <20200424201623.10971-12-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-12-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890CEEEC7D3BCD03F389635BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 11/19] igc: Fix NFC rule overwrite cases
> 
> When the 'loc' argument is passed in ethtool, the input rule overwrites
> any rule present in that location. In this situation we must disable the
> old rule otherwise it is left enabled in hardware. This patch fixes
> the issue by always calling igc_disable_nfc_rule() when deleting the
> old rule, no matter the value of 'input' argument.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
