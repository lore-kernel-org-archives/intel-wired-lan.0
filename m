From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:33:51 +0000
Subject: [Intel-wired-lan] [PATCH S34 v3 1/6] ice: Create and register
 virtual bus for RDMA
In-Reply-To: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
References: <20200121162021.17107-1-anthony.l.nguyen@intel.com>
Message-ID: <d3719a7426404bbfb7fac958d90720d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, January 21, 2020 8:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v3 1/6] ice: Create and register virtual
> bus for RDMA
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The RDMA block does not have its own PCI function, instead it must utilize
> the ice driver to gain access to the PCI device. Create a virtual bus device so
> the irdma driver can register a virtual bus driver to bind to it and receive
> device data. The device data contains all of the relevant information that the
> irdma peer will need to access this PF's IIDC API callbacks.
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
>  drivers/net/ethernet/intel/ice/ice.h          |  13 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  15 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  31 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   3 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 422 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  67 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  11 +
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  56 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  include/linux/net/intel/iidc.h                | 337 ++++++++++++++
>  16 files changed, 961 insertions(+), 2 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_idc.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_idc_int.h
>  create mode 100644 include/linux/net/intel/iidc.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


