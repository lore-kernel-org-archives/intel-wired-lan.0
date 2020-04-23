From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:29:15 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] igc: Fix MAX_ETYPE_FILTER value
In-Reply-To: <20200407210711.24371-4-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
 <20200407210711.24371-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28905BC85C76836DB1D6F153BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, April 7, 2020 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] igc: Fix MAX_ETYPE_FILTER value
> 
> The I225 controller has 8 ethertype filters, not 4. This patch fixes the
> MAX_ETYPE_FILTER macro accordingly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
