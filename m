From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:10:11 +0000
Subject: [Intel-wired-lan] [PATCH 03/19] igc: Cleanup _get|set_rxnfc
 ethtool ops
In-Reply-To: <20200424201623.10971-4-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28904CE78E131B395602ECDABCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 03/19] igc: Cleanup _get|set_rxnfc ethtool
> ops
> 
> This patch does a trivial change in igc_ethtool_get_rxnfc() and
> igc_ethtool_set_rxnfc() to simplify their logic.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 33 ++++++--------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
