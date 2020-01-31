From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 31 Jan 2020 14:58:14 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 1/2] igc: Add support
 for taprio offloading
In-Reply-To: <158050982729.48357.4154736677956638535@aguedesl-mac01.jf.intel.com>
References: <20200130213455.191163-1-vinicius.gomes@intel.com>
 <20200130213455.191163-2-vinicius.gomes@intel.com>
 <158050982729.48357.4154736677956638535@aguedesl-mac01.jf.intel.com>
Message-ID: <878slnb5dl.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

<andre.guedes@linux.intel.com> writes:

> Hi Vinicius,
>
> Quoting Vinicius Costa Gomes (2020-01-30 13:34:54)
>> @@ -418,6 +422,10 @@ struct igc_adapter {
>>         u32 max_frame_size;
>>         u32 min_frame_size;
>>  
>> +       ktime_t base_time;
>> +       ktime_t cycle_time;
>> +       bool baset_set;
>
> 'baset_set' is not used anywhere in the code.

Will fix. It was a leftover from a previous version.

>
>> @@ -565,6 +573,8 @@ int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
>>  int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
>>  void igc_ptp_tx_hang(struct igc_adapter *adapter);
>>  
>> +int igc_tsn_offload_apply(struct igc_adapter *adapter);
>
> Since this patch adds the igc_tsn.c, how about we create the igc_tsn.h as
> well and put this prototype there, following the apporach implemented in other
> parts of the driver e.g. base, mac, nvm, etc.?
>

I can do that. 

>> @@ -428,6 +432,22 @@
>>  #define IGC_TSYNCTXCTL_START_SYNC              0x80000000  /* initiate sync */
>>  #define IGC_TSYNCTXCTL_TXSYNSIG                        0x00000020  /* Sample TX tstamp in PHY sop */
>>  
>> +/* Transmit Scheduling */
>> +#define IGC_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
>> +#define IGC_TQAVCTRL_ENHANCED_QAV      0x00000008
>> +
>> +#define IGC_TXQCTL_QUEUE_MODE_LAUNCHT  0x00000001
>> +#define IGC_TXQCTL_STRICT_CYCLE                0x00000002
>> +#define IGC_TXQCTL_STRICT_END          0x00000004
>> +#define IGC_TXQCTL_PREEMPTIBLE         0x00000008
>> +
>> +#define IGC_BASET_L_AUTO_SET           0x40000000
>> +#define IGC_BASET_L_COPY_H             0x80000000
>> +
>> +#define IGC_QBVCYCLET_S_PLUS1          0x80000000
>> +
>> +#define IGC_TSAUXC_DISABLE_SYSTIME_0   BIT(31)
>
> Most of this macros aren't used in the code. I'd suggest we add them when they
> are needed.
>
> Also, IGC_TXQCTL_QUEUE_MODE_LAUNCHT is not used by this patch, but by the next
> one so it should probably be introduced in the next patch.

Will fix this as well.

>
>> +static bool validate_schedule(const struct tc_taprio_qopt_offload *qopt)
>> +{
>> +       int queue_uses[IGC_MAX_TX_QUEUES] = { };
>> +       size_t n;
>> +
>> +       if (qopt->cycle_time_extension)
>> +               return false;
>> +
>> +       for (n = 0; n < qopt->num_entries; n++) {
>> +               const struct tc_taprio_sched_entry *e;
>> +               int i;
>> +
>> +               e = &qopt->entries[n];
>> +
>> +               for (i = 0; i < IGC_MAX_TX_QUEUES; i++) {
>> +                       if (e->gate_mask & BIT(i))
>> +                               queue_uses[i]++;
>> +
>> +                       /* i225 only supports "global" frame
>> +                        * preemption settings
>> +                        */
>> +                       if (e->command != TC_TAPRIO_CMD_SET_GATES)
>> +                               return false;
>
> We can move this check to the outer loop.

Oh, yeah. Will fix.

>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> new file mode 100644
>> index 000000000000..affffce0e870
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c)  2019 Intel Corporation */
>> +
>> +#include "igc.h"
>> +
>> +/* Returns the TSN specific registers to their default values after
>> + * TSN offloading is disabled.
>> + */
>> +static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>> +{
>> +       struct igc_hw *hw = &adapter->hw;
>> +       u32 tqavctrl;
>> +       int i;
>> +
>> +       if (!(adapter->flags & IGC_FLAG_TSN_QBV_ENABLED))
>> +               return 0;
>> +
>> +       adapter->cycle_time = 0;
>> +
>> +       wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
>
> Don't we want to reset IGC_DTXMXPKTSZ register as well since we touch it in
> igc_tsn_enable_offload()?

Oh, yeah. Will fix.

>
>> +int igc_tsn_offload_apply(struct igc_adapter *adapter)
>> +{
>> +       bool is_any_enabled = adapter->base_time;
>> +
>> +       if (!(adapter->flags & IGC_FLAG_TSN_QBV_ENABLED) && !is_any_enabled)
>> +               return 0;
>> +
>> +       if (!is_any_enabled) {
>> +               int err = igc_tsn_disable_offload(adapter);
>> +
>> +               if (err < 0)
>> +                       return err;
>> +
>> +               /* The BASET registers aren't cleared when writing
>> +                * into them, force a reset if the interface is
>> +                * running.
>> +                */
>> +               if (netif_running(adapter->netdev))
>> +                       schedule_work(&adapter->reset_task);
>> +
>> +               return err;
>
> Nitpicking: return 0 instead.

Will fix.

