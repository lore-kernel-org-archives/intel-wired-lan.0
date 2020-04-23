From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:28:19 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] igc: Refactor ethertype filtering
 code
In-Reply-To: <20200407210711.24371-5-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
 <20200407210711.24371-5-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28904BC9DC287BB8BD964038BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, April 7, 2020 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/5] igc: Refactor ethertype filtering code
> 
> The whole ethertype filtering code is implemented in igc_ethtool.c and
> mixes logic from ethtool and core parts. This patch refactors it so core
> logic is moved to igc_main.c, aligning the ethertype filtering code
> organization with the rest of the filtering code from the driver (MAC
> address and VLAN priority).
> 
> Besides moving code to igc_main.c, this patch also does some minor
> improvements to the code. Below are some highlights.
> 
> In case all filters are already in use and the user tries to add another
> filter, we return -ENOSPC instead of -EINVAL so a more meaningful error
> code is provided. This also aligns with the behavior implemented in MAC
> address filtering code.
> 
> With this code refactoring, 'etype_bitmap' array in struct igc_adapter
> and 'etype_reg_index' in struct igc_nfc_filter are not needed anymore
> and are removed.
> 
> Log messages are added to help debugging the ethertype filtering code.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  4 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 67 ++------------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 93 ++++++++++++++++++++
>  3 files changed, 103 insertions(+), 61 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
