From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:10:15 +0000
Subject: [Intel-wired-lan] [PATCH S25 01/12] ice: update ethtool stats
 on-demand
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA54@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 01/12] ice: update ethtool stats on-
> demand
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Users expect ethtool statistics to be updated on-demand when invoking
> 'ethtool -S <iface>' instead of providing a snapshot of statistics taken once a
> second (the frequency of the watchdog task where stats are currently
> updated).  Update stats every time 'ethtool -S <iface>' is run.
> 
> Also, fix an indentation style issue and an unnecessary local variable
> initialization in ice_get_ethtool_stats() discovered while investigating the
> subject issue.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 +++++--
>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++----
>  3 files changed, 9 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


