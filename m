From: Lu, Nannan <nannan.lu@intel.com>
Date: Wed, 24 Jun 2020 05:18:35 +0000
Subject: [Intel-wired-lan] [PATCH v3 0/5] ice: add Intel DCF mode support
In-Reply-To: <20200624020801.104003-1-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200624020801.104003-1-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB39007E7041594016AEEC8A93F8950@DM6PR11MB3900.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tested-by: Lu, Nannan <nannan.lu@intel.com>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Wednesday, June 24, 2020 10:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 0/5] ice: add Intel DCF mode support
> 
> The iproute2 and ethtool are evolving to expose the NIC hardware capability.
> But these available orchestration methods in Linux kernel are limited in their
> capability to exercise advance functionality in the hardware, since different
> vendors may have different data programming method.
> 
> Intel Ethernet Adaptive Virtual Function (AVF) is the common hardware interface
> for SR-IOV, it has the defined message format to talks with the PF.
> 
> To make good use of the advanced functionality like Switch (Binary Classifier),
> The ice PF driver introduces a DCF (Device Config Function) mode to extend the
> AVF feature.
> 
> The DCF (Device Config Function) method wraps an raw flow admin queue
> command in a virthcnl message and sends it to the PF to be executed. This is
> required because it doesn't have the privilege level to issue the admin queue
> commands, so it acts as a proxy PF. So that the user can customize the AVF
> feature, and use their own programming language to translate the flow rule
> management data into ice raw flow, these raw flows then can be executed in
> PF's sandbox.
> 
> And the kernel PF driver fully controls the behavior of DCF for security, like only
> the trusted VF with ID zero can run into DCF mode, and also for being
> compatible with the common AVF feature, the VF needs to advertise and acquire
> DCF capability firstly.
> 
> v3: Remove the unused function, and control the ice_aq_sw_rules scope by
> CONFIG_PCI_IOV.
>     Capitalize all abbreviations.
> 
> v2: fix the macro ICE_DCF_VFID definition style issue.
> 
> Haiyue Wang (5):
>   ice: add the virtchnl handler for AdminQ command
>   ice: add DCF cap negotiation and state machine
>   ice: support to get the VSI mapping
>   ice: enable DDP package info querying
>   ice: add switch rule management for DCF
> 
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   6 +
>  drivers/net/ethernet/intel/ice/ice_dcf.c      | 839 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      |  91 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  27 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  37 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 366 ++++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   1 +
>  include/linux/avf/virtchnl.h                  |  63 ++
>  12 files changed, 1411 insertions(+), 34 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_dcf.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcf.h
> 
> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
