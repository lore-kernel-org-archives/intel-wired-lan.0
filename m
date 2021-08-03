From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 3 Aug 2021 09:11:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 01/12] ice: support basic
 E-Switch mode control
In-Reply-To: <20210625024501.6126-2-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-2-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB455487125EF910181BC47DA59CF09@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Friday, June 25, 2021 8:15 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v3 01/12] ice: support basic E-
>Switch mode control
>
>Write set and get eswitch mode functions used by devlink ops. Use new pf
>struct member eswitch_mode to track current eswitch mode in driver.
>
>Changing eswitch mode is only allowed when there are no VFs created.
>
>Create new file for eswitch related code.
>
>Add config flag ICE_SWITCHDEV to allow user to choose if switchdev support
>should be enabled or disabled.
>
>Use case examples:
>- show current eswitch mode ('legacy' is the default one) [root at localhost]#
>devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode legacy
>
>- move to 'switchdev' mode
>[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode switchdev
>[root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode switchdev
>
>- create 2 VFs
>[root at localhost]# echo 2 > /sys/class/net/ens4f1/device/sriov_numvfs
>
>- unsuccessful attempt to change eswitch mode while VFs are created
>[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode legacy
>devlink answers: Operation not supported
>
>- destroy VFs
>[root at localhost]# echo 0 > /sys/class/net/ens4f1/device/sriov_numvfs
>
>- restore 'legacy' mode
>[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode legacy
>[root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode legacy
>
>Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/Kconfig           | 14 +++++
> drivers/net/ethernet/intel/ice/Makefile      |  1 +
> drivers/net/ethernet/intel/ice/ice.h         |  1 +
> drivers/net/ethernet/intel/ice/ice_devlink.c |  3 +
>drivers/net/ethernet/intel/ice/ice_eswitch.c | 62 ++++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_eswitch.h | 34 +++++++++++
> 6 files changed, 115 insertions(+)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.h
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
