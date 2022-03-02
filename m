From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 2 Mar 2022 08:20:36 +0000
Subject: [Intel-wired-lan] [net-next PATCH 03/25] ice: remove circular
 header dependencies on ice.h
In-Reply-To: <20220223002712.2771809-4-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-4-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB336787B9526490959EFE5A6AFC039@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 5:57 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 03/25] ice: remove circular header
> dependencies on ice.h
> 
> Several headers in the ice driver include ice.h even though they are
> themselves included by that header. The most notable of these is
> ice_common.h, but several other headers also do this.
> 
> Such a recursive inclusion is problematic as it forces headers to be included in
> a strict order, otherwise compilation errors can result. The circular inclusions
> do not trigger an endless loop due to standard header inclusion guards,
> however other errors can occur.
> 
> For example, ice_flow.h defines ice_rss_hash_cfg, which is used by
> ice_sriov.h as part of the definition of ice_vf_hash_ip_ctx.
> 
> ice_flow.h includes ice_acl.h, which includes ice_common.h, and which
> finally includes ice.h. Since ice.h itself includes ice_sriov.h, this creates a
> circular dependency.
> 
> The definition in ice_sriov.h requires things from ice_flow.h, but ice_flow.h
> itself will lead to trying to load ice_sriov.h as part of its process for expanding
> ice.h. The current code avoids this issue by having an implicit dependency
> without the include of ice_flow.h.
> 
> If we were to fix that so that ice_sriov.h explicitly depends on ice_flow.h the
> following pattern would occur:
> 
>   ice_flow.h -> ice_acl.h -> ice_common.h -> ice.h -> ice_sriov.h
> 
> At this point, during the expansion of, the header guard for ice_flow.h is
> already set, so when ice_sriov.h attempts to load the ice_flow.h header it is
> skipped. Then, we go on to begin including the rest of ice_sriov.h, including
> structure definitions which depend on ice_rss_hash_cfg. This produces a
> compiler warning because ice_rss_hash_cfg hasn't yet been included.
> Remember, we're just at the start of ice_flow.h!
> 
> If the order of headers is incorrect (ice_flow.h is not implicitly loaded first in
> all files which include ice_sriov.h) then we get the same failure.
> 
> Removing this recursive inclusion requires fixing a few cases where some
> headers depended on the header inclusions from ice.h. In addition, a few
> other changes are also required.
> 
> Most notably, ice_hw_to_dev is implemented as a macro in ice_osdep.h,
> which is the likely reason that ice_common.h includes ice.h at all. This macro
> implementation requires the full definition of ice_pf in order to properly
> compile.
> 
> Fix this by moving it to a function declared in ice_main.c, so that we do not
> require all files to depend on the layout of the ice_pf structure.
> 
> Note that this change only fixes circular dependencies, but it does not fully
> resolve all implicit dependencies where one header may depend on the
> inclusion of another. I tried to fix as many of the implicit dependencies as I
> noticed, but fixing them all requires a somewhat tedious analysis of each
> header and attempting to compile it separately.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h           |  3 ---
>  drivers/net/ethernet/intel/ice/ice_arfs.h      |  3 +++
>  drivers/net/ethernet/intel/ice/ice_common.h    |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_dcb.h       |  1 +
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c |  1 +
>  drivers/net/ethernet/intel/ice/ice_flow.c      |  1 +
>  drivers/net/ethernet/intel/ice/ice_flow.h      |  2 ++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h   |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c      | 15 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_osdep.h     | 11 +++++++++--
>  drivers/net/ethernet/intel/ice/ice_repr.h      |  1 -
>  drivers/net/ethernet/intel/ice/ice_sriov.h     |  1 -
>  drivers/net/ethernet/intel/ice/ice_type.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_xsk.h       |  1 -
>  14 files changed, 35 insertions(+), 11 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
