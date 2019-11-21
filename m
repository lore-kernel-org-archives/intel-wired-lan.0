From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:22:11 +0000
Subject: [Intel-wired-lan] [PATCH v4] igc: Add legacy power management
 support
In-Reply-To: <20191114075446.20917-1-sasha.neftin@intel.com>
References: <20191114075446.20917-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A711@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, November 13, 2019 11:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4] igc: Add legacy power management
> support
> 
> Add suspend, resume, runtime_suspend, runtime_resume and
> runtime_idle callbacks implementation.
> 
> v1 -> v2:
> Fix christmas tree (Jeff's suggestion)
> Add CONFIG_PM pre-compiler flag
> 
> v2 -> v3
> Fix christmas tree (Jeff's suggestion)
> 
> v3 -> v4
> Fix kbuild test robot error: implicit declaration of function
> __igc_shutdown
> 
> Reported-by: kbuild test robot <lpk@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   2 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  31 ++++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 204
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   9 ++
>  4 files changed, 246 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
