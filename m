From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Oct 2019 19:05:24 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ice: Initialize and register
 multi-function device to provide RDMA
In-Reply-To: <20191003141739.56446-1-anthony.l.nguyen@intel.com>
References: <20191003141739.56446-1-anthony.l.nguyen@intel.com>
Message-ID: <4103d8c13ede4eaf8ec004332bbce82b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 3, 2019 7:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ice: Initialize and register multi-
> function device to provide RDMA
> 
> The RDMA block does not have its own PCI function, instead it must utilize
> the ice driver to gain access to the PCI device. Create an MFD device for the
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
>  MAINTAINERS                                   |   1 +
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |  16 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  31 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   3 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 442 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  81 ++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  11 +
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  70 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  include/linux/net/intel/iidc.h                | 355 ++++++++++++++
>  16 files changed, 1019 insertions(+), 3 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_idc.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_idc_int.h
>  create mode 100644 include/linux/net/intel/iidc.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


