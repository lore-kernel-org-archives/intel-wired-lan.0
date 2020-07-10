From: Lu, Nannan <nannan.lu@intel.com>
Date: Fri, 10 Jul 2020 03:16:18 +0000
Subject: [Intel-wired-lan] [net-next,
 v8 1/5] ice: add the virtchnl handler for AdminQ command
In-Reply-To: <20200710015421.92122-2-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200710015421.92122-1-haiyue.wang@intel.com>
 <20200710015421.92122-2-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB390091C6BD59015C44071924F8650@DM6PR11MB3900.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Friday, July 10, 2020 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next, v8 1/5] ice: add the virtchnl handler for
> AdminQ command
> 
> The DCF (Device Config Function) is a named trust VF (alway with ID 0, single
> entity per PF port) that can act as a sole controlling entity to exercise advance
> functionality such as adding switch rules for the rest of VFs.
> 
> To achieve this approach, this VF is permitted to send some basic AdminQ
> commands to the PF through virtual channel (mailbox), then the PF driver sends
> these commands to the firmware, and returns the response to the VF again
> through virtual channel.
> 
> The AdminQ command from DCF is split into two parts: one is the AdminQ
> descriptor, the other is the buffer (the descriptor has BUF flag set).
> These two parts should be sent in order, so that the PF can handle them
> correctly.
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   6 +
>  drivers/net/ethernet/intel/ice/ice_dcf.c      |  49 +++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      |  20 +++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 130 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   1 +
>  include/linux/avf/virtchnl.h                  |  10 ++
>  8 files changed, 219 insertions(+), 1 deletion(-)  create mode 100644
> 

Tested-by: Nannan Lu <nannan.lu@intel.com>

> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
