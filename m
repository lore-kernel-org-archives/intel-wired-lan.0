From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 8 Aug 2018 18:00:28 +0300
Subject: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
In-Reply-To: <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
References: <20180806115913.GA21556@super_plancton>
 <CAKgT0UcUV8bQRAhyevfnvwE+yWnWjwAkH0WumUoUK4Fa9SCzhg@mail.gmail.com>
 <20180807064222.GA30741@super_plancton>
 <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
Message-ID: <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/8/2018 17:24, Neftin, Sasha wrote:
> On 8/7/2018 09:42, Camille Bordignon wrote:
>> Le lundi 06 ao?t 2018 ? 15:45:29 (-0700), Alexander Duyck a ?crit :
>>> On Mon, Aug 6, 2018 at 4:59 AM, Camille Bordignon
>>> <camille.bordignon@easymile.com> wrote:
>>>> Hello,
>>>>
>>>> Recently we experienced some issues with intel NIC (I219-LM and 
>>>> I219-V).
>>>> It seems that after a wire reconnection, auto-negotation "fails" and
>>>> link speed drips to 10 Mbps.
>>>>
>>>> ?From kernel logs:
>>>> [17616.346150] e1000e: enp0s31f6 NIC Link is Down
>>>> [17627.003322] e1000e: enp0s31f6 NIC Link is Up 10 Mbps Full Duplex, 
>>>> Flow Control: None
>>>> [17627.003325] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: 
>>>> disabling TSO
>>>>
>>>>
>>>> $ethtool enp0s31f6
>>>> Settings for enp0s31f6:
>>>> ???????? Supported ports: [ TP ]
>>>> ???????? Supported link modes:?? 10baseT/Half 10baseT/Full
>>>> ???????????????????????????????? 100baseT/Half 100baseT/Full
>>>> ???????????????????????????????? 1000baseT/Full
>>>> ???????? Supported pause frame use: No
>>>> ???????? Supports auto-negotiation: Yes
>>>> ???????? Supported FEC modes: Not reported
>>>> ???????? Advertised link modes:? 10baseT/Half 10baseT/Full
>>>> ???????????????????????????????? 100baseT/Half 100baseT/Full
>>>> ???????????????????????????????? 1000baseT/Full
>>>> ???????? Advertised pause frame use: No
>>>> ???????? Advertised auto-negotiation: Yes
>>>> ???????? Advertised FEC modes: Not reported
>>>> ???????? Speed: 10Mb/s
>>>> ???????? Duplex: Full
>>>> ???????? Port: Twisted Pair
>>>> ???????? PHYAD: 1
>>>> ???????? Transceiver: internal
>>>> ???????? Auto-negotiation: on
>>>> ???????? MDI-X: on (auto)
>>>> ???????? Supports Wake-on: pumbg
>>>> ???????? Wake-on: g
>>>> ???????? Current message level: 0x00000007 (7)
>>>> ??????????????????????????????? drv probe link
>>>> ???????? Link detected: yes
>>>>
>>>>
>>>> Notice that if disconnection last less than about 5 seconds,
>>>> nothing wrong happens.
>>>> And if after last failure, disconnection / connection occurs again and
>>>> last less than 5 seconds, link speed is back to 1000 Mbps.
>>>>
>>>> [18075.350678] e1000e: enp0s31f6 NIC Link is Down
>>>> [18078.716245] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps Full 
>>>> Duplex, Flow Control: None
>>>>
>>>> The following patch seems to fix this issue.
>>>> However I don't clearly understand why.
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>>>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> index 3ba0c90e7055..763c013960f1 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> @@ -5069,7 +5069,7 @@ static bool e1000e_has_link(struct 
>>>> e1000_adapter *adapter)
>>>> ???????? case e1000_media_type_copper:
>>>> ???????????????? if (hw->mac.get_link_status) {
>>>> ???????????????????????? ret_val = hw->mac.ops.check_for_link(hw);
>>>> -?????????????????????? link_active = !hw->mac.get_link_status;
>>>> +?????????????????????? link_active = false;
>>>> ???????????????? } else {
>>>> ???????????????????????? link_active = true;
>>>> ???????????????? }
>>>>
>>>> Maybe this is related to watchdog task.
>>>>
>>>> I've found out this fix by comparing with last commit that works fine :
>>>> commit 0b76aae741abb9d16d2c0e67f8b1e766576f897d.
>>>> However I don't know if this information is relevant.
>>>>
>>>> Thank you.
>>>> Camille Bordignon
>>>
>>> What kernel were you testing this on? I know there have been a number
>>> of changes over the past few months in this area and it would be
>>> useful to know exactly what code base you started out with and what
>>> the latest version of the kernel is you have tested.
>>>
>>> Looking over the code change the net effect of it should be to add a 2
>>> second delay from the time the link has changed until you actually
>>> check the speed/duplex configuration. It is possible we could be
>>> seeing some sort of timing issue and adding the 2 second delay after
>>> the link event is enough time for things to stabilize and detect the
>>> link at 1000 instead of 10/100.
>>>
>>> - Alex
>>
>> We've found out this issue using Fedora 27 (4.17.11-100.fc27.x86_64).
>>
>> Then I've tested wth a more recent version of the driver v4.18-rc7 but
>> behavior looks the same.
>>
>> Thanks for you reply.
>>
>> Camille Bordignon
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
> I've agree with Alex. Let's try add 2s delay after a link event. Please, 
> let us know if it will solve your problem.
> Also, I would like recommend try work with different link partner and 
> see if you see same problem.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
Camille,
My apologies, I wrong understand Alex. Please, do not try add delay. 
Please, check if you see same problem with different link partners.
Thanks,
Sasha
