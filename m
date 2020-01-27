From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:14:55 +0000
Subject: [Intel-wired-lan] [PATCH S38 07/15] ice: Fix implicit queue
 mapping mode in ice_vsi_get_qs
In-Reply-To: <20200122152138.41585-7-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-7-anthony.l.nguyen@intel.com>
Message-ID: <484d94228fe84523aa28d2a70a5d111e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 07/15] ice: Fix implicit queue mapping
> mode in ice_vsi_get_qs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently in ice_vsi_get_qs() we set the mapping_mode for Tx and Rx to
> vsi->[tx|rx]_mapping_mode, but the problem is vsi-
> >[tx|rx]_mapping_mode
> have not been set yet. This was working because ICE_VSI_MAP_CONTIG is
> defined to 0. Fix this by being explicit with our mapping mode by initializing
> the Tx and Rx structure's mapping_mode to ICE_VSI_MAP_CONTIG and then
> setting the vsi->[tx|rx]_mapping_mode to the
> [tx|rx]_qs_cfg.mapping_mode values.
> 
> Also, only assign the vsi->[tx|rx]_mapping_mode when the queues are
> successfully mapped to the VSI. With this change there was no longer a need
> to initialize the ret variable to 0 so remove that.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


