From: Lu, Nannan <nannan.lu@intel.com>
Date: Wed, 24 Jun 2020 07:29:17 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/5] ice: add DCF cap negotiation
 and state machine
Message-ID: <DM6PR11MB3900972A5B75352AF9ACB601F8950@DM6PR11MB3900.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: Wednesday, June 24, 2020 10:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Wang, Haiyue <haiyue.wang@intel.com>; Li, Xiaoyun <xiaoyun.li@intel.com>
> Subject: [PATCH v3 2/5] ice: add DCF cap negotiation and state machine
>
> The trust VF0 needs to negotiate the DCF capability firstly. Then the PF
> driver may allow this VF to enter into DCF "ON" state if various checks
> are passed. In DCF "ON" state, the VF0 can send the AdminQ command to do
> advanced switch rules creation for other VFs.
>
> If one of the VFs resets, its hardware VSI number may be changed, so the
> VF0 will enter into the DCF "BUSY" state immediately to avoid adding the
> wrong rule. After the reset is done, the DCF state is changed to "PAUSE"
> mode, and a DCF_VSI_MAP_UPDATE event will be sent to the VF0. This event
> notifies the VF0 to restart negotiating the DCF capability again.
>
> Also the VF0 can exits the DCF service gracefully by issuing the virtual
> channel command OP_DCF_DISABLE.
>
> The system administrator can disable the DCF service by changing the
> trust mode to untrusted.
>
> Signed-off-by: Xiaoyun Li <xiaoyun.li@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcf.c      | 77 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      | 24 ++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 85 ++++++++++++++++++-
>  include/linux/avf/virtchnl.h                  |  9 ++
>  4 files changed, 194 insertions(+), 1 deletion(-)
>

Tested-by: Nannan Lu <nannan.lu@intel.com>

> --
> 2.27.0
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200624/60131b4f/attachment-0001.html>
