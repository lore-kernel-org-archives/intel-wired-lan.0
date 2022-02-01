From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Tue, 1 Feb 2022 11:44:46 -0800
Subject: [Intel-wired-lan] [PATCH net-next 02/19] iecm: add basic module
 init and documentation
In-Reply-To: <20220128001009.721392-3-alan.brady@intel.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-3-alan.brady@intel.com>
Message-ID: <CAP-MU4OwDLJ623dDX7kJhXaTQqBM0coyLxAL06C3pKB_EO8Caw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 27, 2022 at 4:34 PM Alan Brady <alan.brady@intel.com> wrote:
>
> This adds the basics needed to make a kernel module and documentation
> needed to use iecm module.
>

[ snip ]

> diff --git a/drivers/net/ethernet/intel/iecm/Makefile b/drivers/net/ethernet/intel/iecm/Makefile
> new file mode 100644
> index 000000000000..d2d087ac71e9
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/iecm/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2019 Intel Corporation
> +
> +#
> +# Makefile for the Intel(R) Data Plane Function Linux Driver

Maybe the iecm here rather than idpf?

> +#
> +
> +obj-$(CONFIG_IECM) += iecm.o
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/intel/include
> +
> +iecm-y := \
> +       iecm_main.o
> diff --git a/drivers/net/ethernet/intel/iecm/iecm_main.c b/drivers/net/ethernet/intel/iecm/iecm_main.c
> new file mode 100644
> index 000000000000..7c09403c6918
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/iecm/iecm_main.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2019 Intel Corporation */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "iecm.h"
> +
> +#define DRV_SUMMARY    "Intel(R) Ethernet Common Module"
> +static const char iecm_driver_string[] = DRV_SUMMARY;
> +static const char iecm_copyright[] = "Copyright (c) 2020, Intel Corporation.";

Do you want this copyright string "2020" to match the top of the file "2019"?

> +
> +MODULE_DESCRIPTION(DRV_SUMMARY);
> +MODULE_LICENSE("GPL v2");
> +
> +/**
> + * iecm_module_init - Driver registration routine
> + *
> + * iecm_module_init is the first routine called when the driver is
> + * loaded. All it does is register with the PCI subsystem.
> + */
> +static int __init iecm_module_init(void)
> +{
> +       pr_info("%s - version %d\n", iecm_driver_string, LINUX_VERSION_CODE);
> +       pr_info("%s\n", iecm_copyright);
> +
> +       return 0;
> +}
> +module_init(iecm_module_init);
> +
> +/**
> + * iecm_module_exit - Driver exit cleanup routine
> + *
> + * iecm_module_exit is called just before the driver is removed
> + * from memory.
> + */
> +static void __exit iecm_module_exit(void)
> +{
> +       pr_info("module unloaded\n");
> +}
> +module_exit(iecm_module_exit);
> diff --git a/drivers/net/ethernet/intel/include/iecm.h b/drivers/net/ethernet/intel/include/iecm.h
> new file mode 100644
> index 000000000000..f66f0d7db8e7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/include/iecm.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2019 Intel Corporation */
> +
> +#ifndef _IECM_H_
> +#define _IECM_H_
> +
> +#include <linux/etherdevice.h>
> +#include <linux/version.h>
> +
> +#endif /* !_IECM_H_ */
> --
> 2.33.0
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
