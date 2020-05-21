From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 May 2020 07:23:59 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: disable s0ix entry and
 exit flows for ME systems
In-Reply-To: <20200507171406.6883-1-vitaly.lifshits@intel.com>
References: <20200507171406.6883-1-vitaly.lifshits@intel.com>
Message-ID: <DM6PR11MB2890BA07ECF487EE8969C454BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Vitaly
> Lifshits
> Sent: Thursday, May 7, 2020 10:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] e1000e: disable s0ix entry and exit flows
> for ME systems
> 
> Since ME systems do not support SLP_S0 in S0ix state, and S0ix entry
> and exit flows may cause errors on them it is best to avoid using
> e1000e_s0ix_entry_flow and e1000e_s0ix_exit_flow functions.
> 
> This was done by creating a struct of all devices that comes with ME
> and by checking if the current device has ME.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 45
> ++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

