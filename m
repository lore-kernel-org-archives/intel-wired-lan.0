From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 00:40:00 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Enable NETIF_F_HW_TC flag
In-Reply-To: <20200303002808.14210-1-sasha.neftin@intel.com>
References: <20200303002808.14210-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9720140F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, March 2, 2020 4:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Enable NETIF_F_HW_TC flag
> 
> This assignment of the feature NETIF_F_HW_TC
> occurs prior to the initial setup of the local
> hw_features variable.
> 
> This ensures that NETIF_F_HW_TC are marked
> as user changeable, and also enables it by
> default when the driver loads.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
