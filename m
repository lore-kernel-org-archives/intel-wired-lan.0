From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:05:20 +0000
Subject: [Intel-wired-lan] [PATCH 02/19] igc: Get rid of
 igc_max_channels()
In-Reply-To: <20200424201623.10971-3-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289052AD4F83B41D7A55BB6BBCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 02/19] igc: Get rid of igc_max_channels()
> 
> The local function igc_max_channels() is a pointless wrapper around
> igc_get_max_rss_queues(). This patch removes it and updates the callers
> accordingly. It also does some cleanup on igc_get_max_rss_queues().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 ++-------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 7 +------
>  2 files changed, 3 insertions(+), 13 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
