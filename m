From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 14 Mar 2022 04:46:44 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] ice: fix NULL pointer
 dereference in ice_update_vsi_tx_ring_stats()
In-Reply-To: <20220307174739.55899-1-maciej.fijalkowski@intel.com>
References: <20220307174739.55899-1-maciej.fijalkowski@intel.com>
Message-ID: <BYAPR11MB3367D9730C0C04E6626D744FFC0F9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Monday, March 7, 2022 11:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; dan.carpenter at oracle.com; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net] ice: fix NULL pointer dereference
> in ice_update_vsi_tx_ring_stats()
> 
> It is possible to do NULL pointer dereference in routine that updates Tx ring
> stats. Currently only stats and bytes are updated when ring pointer is valid,
> but later on ring is accessed to propagate gathered Tx stats onto VSI stats.
> 
> Change the existing logic to move to next ring when ring is NULL.
> 
> Fixes: e72bba21355d ("ice: split ice_ring onto Tx/Rx separate structs")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
