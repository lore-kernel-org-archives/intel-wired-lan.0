From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:56:26 +0000
Subject: [Intel-wired-lan] [PATCH 09/12] igc: Remove
 igc_*_mac_steering_filter() wrappers
In-Reply-To: <20200318230102.36952-10-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-10-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DED9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 09/12] igc: Remove
> igc_*_mac_steering_filter() wrappers
> 
> With the previous two patches, igc_add_mac_steering_filter() and
> igc_del_mac_steering_filter() became a pointless wrapper of
> igc_add_mac_filter() and igc_del_mac_filter().
> 
> This patch removes these wrappers and update callers to call
> igc_add_mac_filter() and igc_del_mac_filter() directly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  8 ++++----
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 20 ++++++++------------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 20 ++++----------------
>  3 files changed, 16 insertions(+), 32 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
