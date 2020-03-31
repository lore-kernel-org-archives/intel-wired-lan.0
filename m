From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 19:59:57 +0000
Subject: [Intel-wired-lan] [PATCH 04/12] igc: Fix igc_uc_unsync()
In-Reply-To: <20200318230102.36952-5-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-5-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DDB8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 04/12] igc: Fix igc_uc_unsync()
> 
> In case igc_del_mac_filter() returns error, that error is masked
> since the functions always return 0 (success). This patch fixes
> igc_uc_unsync() so it returns whatever value igc_del_mac_filter()
> returns (0 on success, negative number on error).
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
