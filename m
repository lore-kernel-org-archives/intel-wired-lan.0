From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 22 Oct 2020 19:21:04 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: allow turning s0ix flows
 on for systems with ME
In-Reply-To: <20200928044024.7595-2-mario.limonciello@dell.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
 <20200928044024.7595-2-mario.limonciello@dell.com>
Message-ID: <DM6PR11MB2890B9B211E9F5F9A78EE978BC1D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mario Limonciello
> Sent: Sunday, September 27, 2020 9:40 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Perry.Yuan at dell.com; Yijun.Shen at dell.com; linux-kernel at vger.kernel.org;
> Mario Limonciello <mario.limonciello@dell.com>
> Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: allow turning s0ix flows on for
> systems with ME
> 
> S0ix for GBE flows are needed for allowing the system to get into deepest
> power state, but these require coordination of components outside of
> control of Linux kernel.  For systems that have confirmed to coordinate
> this properly, allow turning on the s0ix flows at load time or runtime.
> 
> Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  .../device_drivers/ethernet/intel/e1000e.rst  |  23 ++++
>  drivers/net/ethernet/intel/e1000e/e1000.h     |   7 ++
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  64 +++++-----
>  drivers/net/ethernet/intel/e1000e/param.c     | 110 ++++++++++++++++++
>  4 files changed, 166 insertions(+), 38 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
