From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Mon, 25 Apr 2022 10:27:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: get switch id on
 switchdev devices
In-Reply-To: <20220420112243.142168-1-marcin.szycik@linux.intel.com>
References: <20220420112243.142168-1-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB45540269C45946FBC1835CBC9CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Wednesday, April 20, 2022 4:53 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: get switch id on switchdev
>devices
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Switch id should be the same for each netdevice on a driver.
>The id must be unique between devices on the same system, but does not
>need to be unique between devices on different systems.
>
>The switch id is used to locate ports on a switch and to know if aggregated
>ports belong to the same switch.
>
>To meet this requirements, use pci_get_dsn as switch id value, as this is
>unique value for each devices on the same system.
>
>Implementing switch id is needed by automatic tools for kubernetes.
>
>Set switch id by setting devlink port attribiutes and calling
>devlink_port_attrs_set while creating pf (for uplink) and vf (for representator)
>devlink port.
>
>To get switch id (in switchdev mode):
>cat /sys/class/net/$PF0/phys_switch_id
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 22 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c    | 15 +++++++++++++
> 2 files changed, 37 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
