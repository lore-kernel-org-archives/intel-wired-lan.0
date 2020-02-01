From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Feb 2020 02:27:08 +0000
Subject: [Intel-wired-lan] [PATCH v2] igc: Complete to commit Add basic
 skeleton for PTP
In-Reply-To: <20200122092113.28381-1-sasha.neftin@intel.com>
References: <20200122092113.28381-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971D2726@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, January 22, 2020 1:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igc: Complete to commit Add basic
> skeleton for PTP
> 
> commit 5f2958052c58 ("igc: Add basic skeleton for PTP") added basic
> support for PTP, what's missing is support for suspending.
> Legacy power management has been added. Now we can add
> the suspend method to the igc_shutdown.
> By cleaning the runtime storage for timestamp this avoids a possible
> invalid memory access when the system comes back from suspend state.
> 
> v1->v2:
> Address community comment
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
>  drivers/net/ethernet/intel/igc/igc_ptp.c  | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
