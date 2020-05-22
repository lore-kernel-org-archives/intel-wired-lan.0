From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:14:38 +0000
Subject: [Intel-wired-lan] [PATCH S43 01/15] ice: Call ice_aq_set_mac_cfg
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659DBE1702110307E68D26C8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 01/15] ice: Call ice_aq_set_mac_cfg
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> As per the specification, the driver needs to call set_mac_cfg (opcode
> 0x0603) to be able to exercise jumbo frames. Call the function during
> initialization and the post reset rebuild flow.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 21 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 69
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  2 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  5 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
>  5 files changed, 103 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


