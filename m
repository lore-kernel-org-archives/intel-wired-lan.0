From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:24:19 +0000
Subject: [Intel-wired-lan] [PATCH S44 06/14] ice: avoid undefined
 behavior
In-Reply-To: <20200516004226.4795-6-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-6-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659BB83B798B2EF26E24D2D8CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 06/14] ice: avoid undefined behavior
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> When writing the driver's struct ice_tlan_ctx structure, do not write the 8-bit
> element int_q_state with the associated internal-to-hardware field which is
> 122-bits, otherwise the helper function ice_write_byte() will use undefined
> behavior when setting the mask used for that write.  This should not cause
> any functional change and will avoid use of undefined behavior.
> Also, update a comment to highlight this structure element is not written.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c      |  5 +++--
>  drivers/net/ethernet/intel/ice/ice_common.c    | 12 ++++++++++--
>  drivers/net/ethernet/intel/ice/ice_common.h    |  3 ++-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |  2 +-
>  4 files changed, 16 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


