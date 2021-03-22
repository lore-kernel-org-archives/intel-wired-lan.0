From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 22 Mar 2021 23:50:42 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix oops at i40e_rebuild()
In-Reply-To: <20210218215535.277482-1-arkadiusz.kubalewski@intel.com>
References: <20210218215535.277482-1-arkadiusz.kubalewski@intel.com>
Message-ID: <CO1PR11MB51051A93C99852BF71889D38FA659@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Thursday, February 18, 2021 1:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix oops at i40e_rebuild()
> 
> Setup TC before the i40e_setup_pf_switch() call.
> Memory must be inititalized for all the queues before using its resources.
> 
> Previously it could be possible that a call:
> xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev, rx_ring-
> >queue_index, rx_ring->q_vector->napi.napi_id); was made with q_vector
> being null.
> 
> Oops could show up with the following sequence:
> - no driver loaded
> - FW LLDP agent is on (flag disable-fw-lldp:off)
> - link is up
> - DCB configured with number of Traffic Classes that will not divide
>   completely the default number of queues (usually cpu cores)
> - driver load
> - set private flag: disable-fw-lldp:on
> 
> Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based
> DCB")
> Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel
