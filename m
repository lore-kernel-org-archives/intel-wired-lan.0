From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 18 Apr 2020 04:00:17 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: fix S0ix flows for cable
 connected case
In-Reply-To: <20200312115707.6534-1-vitaly.lifshits@intel.com>
References: <20200312115707.6534-1-vitaly.lifshits@intel.com>
Message-ID: <DM6PR11MB28902EB7C6FF2F8818ADB21ABCD60@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vitaly Lifshits
> Sent: Thursday, March 12, 2020 4:57 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] e1000e: fix S0ix flows for cable
> connected case
> 
> Added a fix to S0ix entry and exit flows for TGP and above
> MAC types, to the case when the ethernet cable is connected
> and the link is up. With that the system is able to reach
> SLP_S0 when going to freeze power state.
> 
> Change-type: ImplementationChange
> Title: e1000e: fix S0ix flows for cable connected case
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 54
> ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/e1000e/regs.h   |  3 ++
>  2 files changed, 57 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
