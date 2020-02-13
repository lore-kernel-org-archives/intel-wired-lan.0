From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 12 Feb 2020 16:23:03 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/2] igc: Add support
 for ETF offloading
In-Reply-To: <158136684850.75536.15541483288653337386@1.0.0.127.in-addr.arpa>
References: <20200207182443.1501016-1-vinicius.gomes@intel.com>
 <20200207182443.1501016-3-vinicius.gomes@intel.com>
 <158136684850.75536.15541483288653337386@1.0.0.127.in-addr.arpa>
Message-ID: <87a75nwd20.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Andre Guedes <andre.guedes@linux.intel.com> writes:

> Hi Vinicius,
>
> Quoting Vinicius Costa Gomes (2020-02-07 10:24:43)
> ...
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> ...
>> @@ -4497,6 +4516,32 @@ static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>>         }
>>  }
>>  
>> +static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
>> +                                     bool enable)
>> +{
>> +       struct igc_ring *ring;
>> +       int i;
>> +
>> +       if (queue < 0 || queue > adapter->num_tx_queues)
>> +               return -EINVAL;
>
> I believe we have an off-by-one bug here. Shouldn't it be queue >=
> adapter->num_tx_queues instead?

Will fix this. (just a note that this off-by-one cannot be exploited by
luck almost, mqprio/taprio do the check correctly on their side)

>
>> @@ -4600,6 +4661,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>>         case TC_SETUP_QDISC_TAPRIO:
>>                 return igc_tsn_enable_qbv_scheduling(adapter, type_data);
>>  
>> +       case TC_SETUP_QDISC_ETF:
>> +               return igc_tsn_enable_launchtime(adapter, type_data);
>
> Consider the scenario where both TAPRIO and ETF offloads are disabled and we
> want to enable ETF offload. ETF depends on adapter->base_time is set to work
> properly, but I couldn't find where in this patch it is set. Could you please
> clarify that?
>
> Regards,
>
> Andre

-- 
Vinicius
