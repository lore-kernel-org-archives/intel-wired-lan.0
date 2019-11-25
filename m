From: Gregory Rose <gvrose8192@gmail.com>
Date: Mon, 25 Nov 2019 11:14:14 -0800
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Remove limit of 10
 entries for unicast filter list
In-Reply-To: <CAKgT0UexoZWiF7Z745O3FkA+A+f-E31DhD5mGXjweXecrRJtgw@mail.gmail.com>
References: <20191125142452.21819-1-radoslawx.tyl@intel.com>
 <7e9bbd9b-ee05-b207-a472-77d03c3ee6ac@molgen.mpg.de>
 <CAKgT0UexoZWiF7Z745O3FkA+A+f-E31DhD5mGXjweXecrRJtgw@mail.gmail.com>
Message-ID: <ff7c1cc5-3bec-3ce7-f584-6fb1ef1f9cbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 11/25/2019 10:23 AM, Alexander Duyck wrote:
> On Mon, Nov 25, 2019 at 5:32 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>> Dear Radoslaw,
>>
>>
>> On 2019-11-25 15:24, Radoslaw Tyl wrote:
>>> Currently, though the FDB entry is added to VF, it does not appear in
>>> RAR filters. VF driver only allows to add 10 entries. Attempting to add
>>> another causes an error. This patch removes limitation and allows use of
>>> all free RAR entries for the FDB if needed.
>> I still wonder, why the limit was introduced in the first place.
>> gregory.v.rose at intel.com bounces, so we can?t ask.
> I've added Greg's current email address in case he has some memory for
> why the limit of 10 was added.
>
> It probably has to do with wanting to prevent starvation of resources.
> The hardware itself only supports 128 total RAR entries. So if we have
> 63 VFs and 1 PF, and 15 of PF macvlans, then we would only have 49
> entries to spare that are then shared. So at best this is only pushing
> things out to 49 since at that point we are out of RAR entries anyway.

Hi Alex,

It's tough to recall exactly what my thinking was - 8 years is a long 
time.? However, I think you're
right that this is about resource sharing and not allowing any single VF 
to consume all the remaining
RAR entries.? Ten entries seems arbitrary but I do recall at the time a 
common test setup was with
4 VFs.? Also, we needed to reserve RAR entries for the PF too IIRC.

Maybe Sibai can recall, I don't know if she's still at Intel but maybe 
ask her as well.

Sorry I couldn't be more help.

Regards,

- Greg

>
>>> Fixes: 46ec20ff7d ("ixgbevf: Add macvlan support in the set rx mode op")
> I wouldn't bother with the fixes tag since it isn't "fixing" things.
> It is changing behavior. I would say it was by design that it was
> limited to 10 entries. All this change does is push the work onto the
> PF for returning an error instead of doing so earlier.
>
> For a normal NIC the failure case here would be to enable promiscuous
> mode. However since this is a VF you cannot do that. Instead it might
> make more sense to dump a message when you hit the limit.
>
>>> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 -----
>>>   1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>>> index 076f2da36f27..64ec0e7c64b4 100644
>>> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>>> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>>> @@ -2081,11 +2081,6 @@ static int ixgbevf_write_uc_addr_list(struct net_device *netdev)
>>>        struct ixgbe_hw *hw = &adapter->hw;
>>>        int count = 0;
>>>
>>> -     if ((netdev_uc_count(netdev)) > 10) {
>>> -             pr_err("Too many unicast filters - No Space\n");
>>> -             return -ENOSPC;
>>> -     }
>>> -
>>>        if (!netdev_uc_empty(netdev)) {
>>>                struct netdev_hw_addr *ha;
> I would say NAK. The problem here is this doesn't solve the original
> problem. It just masks it by pushing the failure out to the
> set_uc_addr call which doesn't have the return value checked so
> instead you will get a silent failure.

