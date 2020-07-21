From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Jul 2020 23:25:06 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Clean up the _hw_stats
 structure
In-Reply-To: <20200708070858.6424-1-sasha.neftin@intel.com>
References: <20200708070858.6424-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB289061B20B15E950F8E2AD58BC780@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, July 8, 2020 12:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Clean up the _hw_stats structure
> 
> Remove icrxptc, icrxatc, ictxptc, ictxatc, ictxqec, ictxqmtc,
> icrxdmtc, icrxoc, cbrdpc, cbrmpc and htcbdpc fields from
> the _hw_stats structure. Accordance to the i225 device
> specification these fields not in use.
> This patch come to clean up the driver code.
> 
> v1 -> v2:
> minor complete
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h   | 12 ------------
>  drivers/net/ethernet/intel/igc/igc_mac.c  |  3 ---
>  drivers/net/ethernet/intel/igc/igc_main.c |  2 --
>  drivers/net/ethernet/intel/igc/igc_regs.h |  2 --
>  4 files changed, 19 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
