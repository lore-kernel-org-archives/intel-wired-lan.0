From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 03:10:44 +0000
Subject: [Intel-wired-lan] [net 6/6] ice: fix memory leak in
 ice_vsi_setup
In-Reply-To: <20200902155347.16972-6-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
 <20200902155347.16972-6-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB28903E0D9493384C6B9CECFEBC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, September 2, 2020 8:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net 6/6] ice: fix memory leak in ice_vsi_setup
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> During ice_vsi_setup, if ice_cfg_vsi_lan fails, it does not properly
> release memory associated with the VSI rings. If we had used devres
> allocations for the rings, this would be ok. However, we use kzalloc and
> kfree_rcu for these ring structures.
> 
> Using the correct label to cleanup the rings during ice_vsi_setup
> highlights an issue in the ice_vsi_clear_rings function: it can leave
> behind stale ring pointers in the q_vectors structure.
> 
> When releasing rings, we must also ensure that no q_vector associated
> with the VSI will point to this ring again. To resolve this, loop over
> all q_vectors and release their ring mapping. Because we are about to
> free all rings, no q_vector should remain pointing to any of the rings
> in this VSI.
> 
> Fixes: 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI multi-Tx queue
> support")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
