From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jun 2020 20:11:33 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/5] ice: add DCF cap negotiation
 and state machine
In-Reply-To: <20200619171022.9539-3-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200619171022.9539-1-haiyue.wang@intel.com>
 <20200619171022.9539-3-haiyue.wang@intel.com>
Message-ID: <BN6PR1101MB214555D1AFBC0C87A3DEBCA58C970@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Friday, June 19, 2020 10:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Li, Xiaoyun <xiaoyun.li@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 2/5] ice: add DCF cap negotiation and
> state machine
> 
> The trust VF0 needs to negotiate the DCF capability firstly. Then the PF driver
> may allow this VF to enter into DCF "ON" state if various checks are passed.
> In DCF "ON" state, the VF0 can send the AdminQ command to do advanced
> switch rules creation for other VFs.
> 
> If one of the VFs resets, its hardware VSI number may be changed, so the
> VF0 will enter into the DCF "BUSY" state immediately to avoid adding the
> wrong rule. After the reset is done, the DCF state is changed to "PAUSE"
> mode, and a DCF_VSI_MAP_UPDATE event will be sent to the VF0. This
> event notifies the VF0 to restart negotiating the DCF capability again.
> 
> Also the VF0 can exits the DCF service gracefully by issuing the virtual channel
> command OP_DCF_DISABLE.
> 
> The system administrator can disable the DCF service by changing the trust
> mode to untrusted.
> 
> Signed-off-by: Xiaoyun Li <xiaoyun.li@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcf.c      | 86 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      | 30 +++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 85 +++++++++++++++++-
>  include/linux/avf/virtchnl.h                  |  9 ++
>  4 files changed, 209 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


