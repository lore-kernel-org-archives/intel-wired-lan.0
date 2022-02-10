From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 10 Feb 2022 05:29:10 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Avoid RTNL lock when
 re-creating auxiliary device
In-Reply-To: <20220121002756.1105566-1-david.m.ertman@intel.com>
References: <20220121002756.1105566-1-david.m.ertman@intel.com>
Message-ID: <BYAPR11MB336728CE6F3C8EF91B88D5EDFC2F9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Friday, January 21, 2022 5:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: Avoid RTNL lock when re-creating
> auxiliary device
> 
> If a call to re-create the auxiliary device happens in a context that has already
> taken the RTNL lock, then the call flow that recreates auxiliary device can
> hang if there is another attempt to claim the RTNL lock by the auxiliary driver.
> 
> To avoid this, any call to re-create auxiliary devices that comes from an
> source that is holding the RTNL lock (e.g. netdev notifier when interface exits
> a bond) should execute in a separate thread.  To accomplish this, add a flag to
> the PF that will be evaluated in the service task and dealt with there.
> 
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 3 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
