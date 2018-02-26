From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Feb 2018 10:49:23 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 3/8] igb: Enable the
 hardware traffic class feature bit for igb models
In-Reply-To: <CAKgT0Ufuyf1_9RZe2yqSC404p-i3VpRAqP-2w0mUysCJGq5NKA@mail.gmail.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
 <20180224012036.5834-4-vinicius.gomes@intel.com>
 <CAKgT0Ufuyf1_9RZe2yqSC404p-i3VpRAqP-2w0mUysCJGq5NKA@mail.gmail.com>
Message-ID: <87inajbn7w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Alexander Duyck <alexander.duyck@gmail.com> writes:

> On Fri, Feb 23, 2018 at 5:20 PM, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> This will allow functionality depending on the hardware being traffic
>> class aware to work. In particular the tc-flower offloading checks
>> verifies that this bit is set.
>>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igb/igb_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 0ea32be07d71..543aa99892eb 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -2820,8 +2820,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>                                NETIF_F_HW_VLAN_CTAG_TX |
>>                                NETIF_F_RXALL;
>>
>> -       if (hw->mac.type >= e1000_i350)
>> -               netdev->hw_features |= NETIF_F_NTUPLE;
>> +       if (hw->mac.type >= e1000_i350) {
>> +               netdev->hw_features |= (NETIF_F_NTUPLE | NETIF_F_HW_TC);
>> +               netdev->features |= NETIF_F_HW_TC;
>
> The parens aren't needed.
>
> Also you might consider moving this block up to where we have a
> similar one for 82576. Then you wouldn't need to set both features and
> hw_features in the case of the HW_TC flag.

Cool. Will fix.

>
>> +       }
>>
>>         if (pci_using_dac)
>>                 netdev->features |= NETIF_F_HIGHDMA;
>> --
>> 2.16.2
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Cheers,
--
Vinicius
