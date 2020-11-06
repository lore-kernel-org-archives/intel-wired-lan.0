From: Guedes, Andre <andre.guedes@intel.com>
Date: Fri, 6 Nov 2020 01:01:13 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/9] igc: Fix igc_ptp_rx_pktstamp()
In-Reply-To: <20201104222608.GB39754@ranger.igk.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-2-andre.guedes@intel.com>
 <20201102175617.GI6427@ranger.igk.intel.com>
 <160444679837.10323.6569127492617330628@anemani-mobl2.amr.corp.intel.com>
 <20201104222608.GB39754@ranger.igk.intel.com>
Message-ID: <E144BE99-6924-41B6-A7DD-915133B44C43@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Nov 4, 2020, at 2:26 PM, Fijalkowski, Maciej <maciej.fijalkowski@intel.com> wrote:
> 
>>>> 
>>>> +     /* Adjust timestamp for the RX latency based on link speed */
>>>> +     switch (adapter->link_speed) {
>>>> +     case SPEED_10:
>>>> +             adjust = IGC_I225_RX_LATENCY_10;
>>>> +             break;
>>>> +     case SPEED_100:
>>>> +             adjust = IGC_I225_RX_LATENCY_100;
>>>> +             break;
>>>> +     case SPEED_1000:
>>>> +             adjust = IGC_I225_RX_LATENCY_1000;
>>>> +             break;
>>>> +     case SPEED_2500:
>>>> +             adjust = IGC_I225_RX_LATENCY_2500;
>>>> +             break;
>>>> +     default:
>>>> +             adjust = 0;
>>>> +             netdev_warn_once(adapter->netdev, "Imprecise timestamp\n");
>>> 
>>> How is timestamp related to link speed? I mean, this warning is telling me
>>> that there is something wrong with the timestamp that hw put onto frame,
>>> not that link speed is cranky.
>> 
>> The timestamp is sampled at the beginning of the packet. Although the timestamp
>> logic is located as close as possible to the PHY interface, there is a latency
>> between the moment the PHY received the first bit of the packet and the moment
>> the timestamp logic samples. That latency depends on the link speed and is
>> specified in the datasheet so software can adjust it.
> 
> Thanks for that explanation! I meant that warning should say something
> like "wrong link speed, can not adjust timestamp", but OTOH I have a
> feeling that all of the speeds that this HW supports are handled in this
> switch statement, so probably arguing about that warning is pointless? :)

For TSN use cases, timestamp precision is very important. If, for any reason, adapter->link_speed is off, we want to at least log that information.
