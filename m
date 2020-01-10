From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 10 Jan 2020 00:24:31 +0000
Subject: [Intel-wired-lan] [PATCH v3] igc: Add PHY power management
 control
In-Reply-To: <20200108081924.20008-1-sasha.neftin@intel.com>
References: <20200108081924.20008-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971A9BA1@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Wednesday, January 8, 2020 12:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] igc: Add PHY power management control
> 
> PHY power management control should provide a reliable and accurate
> indication of PHY reset completion and decrease the delay time
> after a PHY reset
> 
> v1 -> v2: add hw_dbg print for a timeout
> v2 -> v3: address some community comments
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_phy.c     | 16 +++++++++++++++-
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
