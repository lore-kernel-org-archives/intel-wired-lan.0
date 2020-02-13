From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 12 Feb 2020 16:13:14 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/2] igc: Add support
 for ETF offloading
In-Reply-To: <158144496367.84624.2078546125857384447@titagi-mobl.amr.corp.intel.com>
References: <20200207182443.1501016-1-vinicius.gomes@intel.com>
 <20200207182443.1501016-3-vinicius.gomes@intel.com>
 <158136684850.75536.15541483288653337386@1.0.0.127.in-addr.arpa>
 <87pnemx6xi.fsf@linux.intel.com>
 <158144496367.84624.2078546125857384447@titagi-mobl.amr.corp.intel.com>
Message-ID: <87eeuzwdid.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Andre Guedes <andre.guedes@linux.intel.com> writes:

> Hi Vinicius,
>
> Quoting Vinicius Costa Gomes (2020-02-10 17:13:13)
>> >> @@ -4600,6 +4661,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>> >>         case TC_SETUP_QDISC_TAPRIO:
>> >>                 return igc_tsn_enable_qbv_scheduling(adapter, type_data);
>> >>  
>> >> +       case TC_SETUP_QDISC_ETF:
>> >> +               return igc_tsn_enable_launchtime(adapter, type_data);
>> >
>> > Consider the scenario where both TAPRIO and ETF offloads are disabled and we
>> > want to enable ETF offload. ETF depends on adapter->base_time is set to work
>> > properly, but I couldn't find where in this patch it is set. Could you please
>> > clarify that?
>> 
>> '->base_time' doesn't need to be set, i.e. if it's zero (which is the
>> case that only ETF offloading is enabled), it should be fine. H
>> 
>> ow we calculate the launchtime in igc_tx_launchtime() is able to handle
>> 'base_time_ being zero just fine, and the BASET_{L,H} registers will
>> have sane values when it's zero as well.
>
> If '->base_time' is never set, I suspect ETF disabling has an issue. See this
> piece of code:
>
> int igc_tsn_offload_apply(struct igc_adapter *adapter)
> {
>         bool is_any_enabled = adapter->base_time || is_any_launchtime(adapter);
>
>         if (!(adapter->flags & IGC_FLAG_TSN_QBV_ENABLED) && !is_any_enabled)
>                 return 0;
>
>         ...
> }
>
> By the time igc_tsn_offload_apply() is called, we had already set
> 'ring->launchtime' to false. Since IGC_FLAG_TSN_QBV_ENABLED isn't set and
> 'is_any_enabled' is false, we return without calling igc_tsn_disable_offload().
>

I am still not seeing the problem.

If ETF offloading was disabled, and then enabled,
igc_save_launchtime_params() got called and some of the queues have
launchtime_enable bit set. igc_save_launchtime_params() calls
igc_tsn_offload_apply() and IGC_FLAG_TSN_QBV_ENABLED is set. Later, when
the user wants to disable ETF offloading (the only way is to remove the
qdisc, remember), the same thing happens: save_launchtime() and then
offload_apply(), but now the IGC_FLAG_TSN_QBV_ENABLED is enabled, but
there's no user, so igc_tsn_disable_offload() is called and the
controller is reset if necessary.

-- 
Vinicius
