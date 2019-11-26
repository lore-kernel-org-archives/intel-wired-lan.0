From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 Nov 2019 19:41:45 +0000
Subject: [Intel-wired-lan] [PATCH S34 v2 1/2] ice: Initialize and
 register a virtual bus to provide RDMA
In-Reply-To: <20191120095417.15124-1-anthony.l.nguyen@intel.com>
References: <20191120095417.15124-1-anthony.l.nguyen@intel.com>
Message-ID: <c5320e0bdf794167a99abfbf9c4f2d34@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 20, 2019 1:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v2 1/2] ice: Initialize and register a
> virtual bus to provide RDMA
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The RDMA block does not have its own PCI function, instead it must utilize
> the ice driver to gain access to the PCI device. Create a virtual bus for the
> RDMA driver to bind to the device data. The device data contains all of the
> relevant information that the IRDMA peer will need to access this PF's IIDC
> API callbacks.
> 
> Note the header file iidc.h is located under include/linux/net/intel as this is a
> unified header file to be used by all consumers of the IIDC interface.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Change usage from MFD to virtual bus
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |  14 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  15 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  31 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   3 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 410 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  79 ++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  11 +
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  65 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  include/linux/net/intel/iidc.h                | 336 ++++++++++++++
>  16 files changed, 969 insertions(+), 2 deletions(-)  create mode 100644

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


