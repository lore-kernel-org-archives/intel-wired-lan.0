From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 19:59:20 +0000
Subject: [Intel-wired-lan] [PATCH 03/12] igc: Change
 igc_add_mac_filter() returning value
In-Reply-To: <20200318230102.36952-4-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-4-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DDA4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 03/12] igc: Change igc_add_mac_filter()
> returning value
> 
> In case of success, igc_add_mac_filter() returns the index in
> adapter->mac_table where the requested filter was added. This
> information, however, is not used by any caller of that function.
> In fact, callers have extra code just to handle this returning
> index as 0 (success).
> 
> So this patch changes the function to return 0 on success instead,
> and cleans up the extra code.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
>  drivers/net/ethernet/intel/igc/igc_main.c    | 7 ++-----
>  2 files changed, 2 insertions(+), 7 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
