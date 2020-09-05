From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 04:01:51 +0000
Subject: [Intel-wired-lan] [net 4/6] ice: Fix call trace on suspend
In-Reply-To: <20200902155347.16972-4-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
 <20200902155347.16972-4-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890072526A61E239FBD70ECBC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, September 2, 2020 8:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net 4/6] ice: Fix call trace on suspend
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> It appears that the ice_suspend flow is missing a call to pci_save_state
> and this is triggering the message "State of device not saved by
> ice_suspend" and a call trace. Fix it.
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
