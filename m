From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Mon, 10 Feb 2020 12:33:59 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 1/2] igc: Add support
 for taprio offloading
In-Reply-To: <20200207182443.1501016-2-vinicius.gomes@intel.com>
References: <20200207182443.1501016-1-vinicius.gomes@intel.com>
 <20200207182443.1501016-2-vinicius.gomes@intel.com>
Message-ID: <158136683984.75536.11605147606262842969@1.0.0.127.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

Quoting Vinicius Costa Gomes (2020-02-07 10:24:42)
...
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
...
> +/* Transmit Scheduling */
> +#define IGC_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
> +#define IGC_TQAVCTRL_ENHANCED_QAV      0x00000008
> +
> +#define IGC_TXQCTL_STRICT_CYCLE                0x00000002
> +#define IGC_TXQCTL_STRICT_END          0x00000004
> +#define IGC_TXQCTL_PREEMPTIBLE         0x00000008

It seems you missed removing IGC_TXQCTL_PREEMPTIBLE here. This macro is not
used anywhere in the code.

> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c)  2018 Intel Corporation */

s/2018/2020 ?

Regards,

Andre
