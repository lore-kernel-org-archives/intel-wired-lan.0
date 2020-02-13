From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 12 Feb 2020 16:24:42 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 1/2] igc: Add support
 for taprio offloading
In-Reply-To: <158136683984.75536.11605147606262842969@1.0.0.127.in-addr.arpa>
References: <20200207182443.1501016-1-vinicius.gomes@intel.com>
 <20200207182443.1501016-2-vinicius.gomes@intel.com>
 <158136683984.75536.11605147606262842969@1.0.0.127.in-addr.arpa>
Message-ID: <874kvvwcz9.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Andre Guedes <andre.guedes@linux.intel.com> writes:

> Hi Vinicius,
>
> Quoting Vinicius Costa Gomes (2020-02-07 10:24:42)
> ...
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> ...
>> +/* Transmit Scheduling */
>> +#define IGC_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
>> +#define IGC_TQAVCTRL_ENHANCED_QAV      0x00000008
>> +
>> +#define IGC_TXQCTL_STRICT_CYCLE                0x00000002
>> +#define IGC_TXQCTL_STRICT_END          0x00000004
>> +#define IGC_TXQCTL_PREEMPTIBLE         0x00000008
>
> It seems you missed removing IGC_TXQCTL_PREEMPTIBLE here. This macro is not
> used anywhere in the code.

Will fix.

>
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)  2018 Intel Corporation */
>
> s/2018/2020 ?

Ugh, will fix.

>
> Regards,
>
> Andre

-- 
Vinicius
