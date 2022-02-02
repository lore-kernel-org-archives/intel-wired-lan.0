From: Brady, Alan <alan.brady@intel.com>
Date: Wed, 2 Feb 2022 22:15:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next 02/19] iecm: add basic module
 init and documentation
In-Reply-To: <20220128115609.20470-1-alexandr.lobakin@intel.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-3-alan.brady@intel.com>
 <20220128115609.20470-1-alexandr.lobakin@intel.com>
Message-ID: <CO1PR11MB51865C73F8AF6B89D91364748F279@CO1PR11MB5186.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> Sent: Friday, January 28, 2022 3:56 AM
> To: Brady, Alan <alan.brady@intel.com>
> Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> lan at lists.osuosl.org; Burra, Phani R <phani.r.burra@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 02/19] iecm: add basic module
> init and documentation
> 
> From: Alan Brady <alan.brady@intel.com>
> Date: Thu, 27 Jan 2022 16:09:52 -0800
> 
> > This adds the basics needed to make a kernel module and documentation
> > needed to use iecm module.
> >
> > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > ---
> >  .../device_drivers/ethernet/intel/iecm.rst    | 93 +++++++++++++++++++
> >  drivers/net/ethernet/intel/Kconfig            | 15 +++
> >  drivers/net/ethernet/intel/Makefile           |  1 +
> >  drivers/net/ethernet/intel/iecm/Makefile      | 13 +++
> >  drivers/net/ethernet/intel/iecm/iecm_main.c   | 40 ++++++++
> >  drivers/net/ethernet/intel/include/iecm.h     | 10 ++
> >  6 files changed, 172 insertions(+)
> >  create mode 100644
> > Documentation/networking/device_drivers/ethernet/intel/iecm.rst
> >  create mode 100644 drivers/net/ethernet/intel/iecm/Makefile
> >  create mode 100644 drivers/net/ethernet/intel/iecm/iecm_main.c
> >  create mode 100644 drivers/net/ethernet/intel/include/iecm.h
> >
> > diff --git
> > a/Documentation/networking/device_drivers/ethernet/intel/iecm.rst
> > b/Documentation/networking/device_drivers/ethernet/intel/iecm.rst
> > new file mode 100644
> > index 000000000000..5634e3e65c74
> > --- /dev/null
> > +++ b/Documentation/networking/device_drivers/ethernet/intel/iecm.rst
> > @@ -0,0 +1,93 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +========================
> > +Intel Ethernet Common Module
> > +========================
> > +
> > +The Intel Ethernet Common Module is meant to serve as an abstraction
> > +layer between device specific implementation details and common net
> > +device driver flows. This library provides several function hooks
> > +which allow a device driver to specify register addresses, control
> > +queue communications, and other device specific functionality.  Some
> > +functions are required to be implemented while others have a default
> > +implementation that is used when none is supplied by the device
> > +driver.  Doing this, a device driver can be written to take advantage
> > +of existing code while also giving the flexibility to implement device specific
> features.
> > +
> > +The common use case for this library is for a network device driver
> > +that wants specify its own device specific details but also leverage
> > +the more common code flows found in network device drivers.
> > +
> > +Sections in this document:
> > +	Entry Point
> > +	Exit Point
> > +	Register Operations API
> > +	Virtchnl Operations API
> > +
> > +Entry Point
> > +~~~~~~~~~~~
> > +The primary entry point to the library is the iecm_probe function.
> > +Prior to calling this, device drivers must have allocated an
> > +iecm_adapter struct and initialized it with the required API
> > +functions.  The adapter struct, along with the pci_dev struct and the
> > +pci_device_id struct, is provided to iecm_probe which finalizes device
> initialization and prepares the device for open.
> > +
> > +The iecm_dev_ops struct within the iecm_adapter struct is the primary
> > +vehicle for passing information from device drivers to the common
> > +module.  A dependent module must define and assign a reg_ops_init
> > +function which will assign the respective function pointers to
> > +initialize register values (see iecm_reg_ops struct).  These are
> > +required to be provided by the dependent device driver as no suitable default
> can be assumed for register addresses.
> > +
> > +The vc_ops_init function pointer and the related iecm_virtchnl_ops
> > +struct are optional and should only be necessary for device drivers
> > +which use a different method/timing for communicating across a
> > +mailbox to the hardware.  Within iecm is a default interface provided
> > +in the case where one is not provided by the device driver.
> > +
> > +Exit Point
> > +~~~~~~~~~~
> > +When the device driver is being prepared to be removed through the
> > +pci_driver remove callback, it is required for the device driver to
> > +call iecm_remove with the pci_dev struct provided.  This is required
> > +to ensure all resources are properly freed and returned to the operating
> system.
> > +
> > +Register Operations API
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +iecm_reg_ops contains three different function pointers relating to
> > +initializing registers for the specific net device using the library.
> > +
> > +ctlq_reg_init relates specifically to setting up registers related to
> > +control queue/mailbox communications.  Registers that should be
> > +defined include: head, tail, len, bah, bal, len_mask, len_ena_mask, and
> head_mask.
> > +
> > +vportq_reg_init relates to setting up queue registers.  The tail
> > +registers to be assigned to the iecm_queue struct for each RX/TX queue.
> > +
> > +intr_reg_init relates to any registers needed to setup interrupts.
> > +These include registers needed to enable the interrupt and change ITR
> settings.
> > +
> > +If the initialization function finds that one or more required
> > +function pointers were not provided, an error will be issued and the
> > +device will be inoperable.
> > +
> > +
> > +Virtchnl Operations API
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +The virtchnl is a conduit between driver and hardware that allows
> > +device drivers to send and receive control messages to/from hardware.
> > +This is optional to be specified as there is a general interface that
> > +can be assumed when using this library.  However, if a device
> > +deviates in some way to communicate across the mailbox correctly,
> > +this interface is provided to allow that.
> > +
> > +If vc_ops_init is set in the dev_ops field of the iecm_adapter
> > +struct, then it is assumed the device driver is using providing it's
> > +own interface to do virtchnl communications.  While providing
> > +vc_ops_init is optional, if it is provided, it is required that the
> > +device driver provide function pointers for those functions in
> > +vc_ops, with exception for the enable_vport, disable_vport, and
> destroy_vport functions which may not be required for all devices.
> > +
> > +If the initialization function finds that vc_ops_init was defined but
> > +one or more required function pointers were not provided, an error
> > +will be issued and the device will be inoperable.
> > diff --git a/drivers/net/ethernet/intel/Kconfig
> > b/drivers/net/ethernet/intel/Kconfig
> > index 3facb55b7161..754dc7677ad5 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -372,4 +372,19 @@ config IGC
> >  	  To compile this driver as a module, choose M here. The module
> >  	  will be called igc.
> >
> > +config IECM
> > +	tristate "Intel(R) Ethernet Common Module Support"
> > +	default n
> > +	depends on PCI_MSI
> > +	select DIMLIB
> > +	help
> > +      This supplies needed functions to device specific device
> > +drivers
> 
> One Tab + two spaces instead of 6 spaces. And one Tab is 8 cols in the kernel.
> 

Will fix

> > +      implementing common module.
> > +
> > +	  More specific information on configuring the driver is in
> > +
> <file:Documentation/networking/device_drivers/ethernet/intel/iecm.rst>.
> > +
> > +      To compile this as a module, choose M here. The module will be called
> > +      iecm.
> > +
> >  endif # NET_VENDOR_INTEL
> > diff --git a/drivers/net/ethernet/intel/Makefile
> > b/drivers/net/ethernet/intel/Makefile
> > index 3075290063f6..c9eba9cc5087 100644
> > --- a/drivers/net/ethernet/intel/Makefile
> > +++ b/drivers/net/ethernet/intel/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_IXGB) += ixgb/
> >  obj-$(CONFIG_IAVF) += iavf/
> >  obj-$(CONFIG_FM10K) += fm10k/
> >  obj-$(CONFIG_ICE) += ice/
> > +obj-$(CONFIG_IECM) += iecm/
> > diff --git a/drivers/net/ethernet/intel/iecm/Makefile
> > b/drivers/net/ethernet/intel/iecm/Makefile
> > new file mode 100644
> > index 000000000000..d2d087ac71e9
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/iecm/Makefile
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only # Copyright (C) 2019 Intel
> > +Corporation
> > +
> > +#
> > +# Makefile for the Intel(R) Data Plane Function Linux Driver #
> > +
> > +obj-$(CONFIG_IECM) += iecm.o
> > +
> > +ccflags-y += -I$(srctree)/drivers/net/ethernet/intel/include
> 
> Common includes are usually being added to include/linux/. Files outside include
> directories are usually considered "private", i.e.
> used only inside a particular folder.
> 

Will fix.

> > +
> > +iecm-y := \
> > +	iecm_main.o
> > diff --git a/drivers/net/ethernet/intel/iecm/iecm_main.c
> > b/drivers/net/ethernet/intel/iecm/iecm_main.c
> > new file mode 100644
> > index 000000000000..7c09403c6918
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/iecm/iecm_main.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2019 Intel Corporation */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include "iecm.h"
> 
> Quotes are used for local includes. For includes from the search directories
> please use <>.
> 
> > +
> > +#define DRV_SUMMARY	"Intel(R) Ethernet Common Module"
> > +static const char iecm_driver_string[] = DRV_SUMMARY; static const
> > +char iecm_copyright[] = "Copyright (c) 2020, Intel Corporation.";
> > +
> > +MODULE_DESCRIPTION(DRV_SUMMARY);
> > +MODULE_LICENSE("GPL v2");
> 
> "GPL v2" is a deprecated identifier and is not recommended for new modules.
> Just "GPL" is enough and means exactly the same.
> 

Will fix

> > +
> > +/**
> > + * iecm_module_init - Driver registration routine
> > + *
> > + * iecm_module_init is the first routine called when the driver is
> > + * loaded. All it does is register with the PCI subsystem.
> > + */
> > +static int __init iecm_module_init(void) {
> > +	pr_info("%s - version %d\n", iecm_driver_string,
> LINUX_VERSION_CODE);
> > +	pr_info("%s\n", iecm_copyright);
> > +
> > +	return 0;
> > +}
> > +module_init(iecm_module_init);
> > +
> > +/**
> > + * iecm_module_exit - Driver exit cleanup routine
> > + *
> > + * iecm_module_exit is called just before the driver is removed
> > + * from memory.
> > + */
> > +static void __exit iecm_module_exit(void) {
> > +	pr_info("module unloaded\n");
> > +}
> > +module_exit(iecm_module_exit);
> > diff --git a/drivers/net/ethernet/intel/include/iecm.h
> > b/drivers/net/ethernet/intel/include/iecm.h
> > new file mode 100644
> > index 000000000000..f66f0d7db8e7
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/include/iecm.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (C) 2019 Intel Corporation */
> > +
> > +#ifndef _IECM_H_
> > +#define _IECM_H_
> > +
> > +#include <linux/etherdevice.h>
> > +#include <linux/version.h>
> > +
> > +#endif /* !_IECM_H_ */
> > --
> > 2.33.0
> 
> Thanks,
> Al
