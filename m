From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 12 Jan 2016 13:34:30 -0800
Subject: [Intel-wired-lan] [next PATCH 03/11] igb: Allow asymmetric
 configuration of MTU versus Rx frame size
In-Reply-To: <alpine.NEB.2.11.1601121001560.1772@chris.i8u.org>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
 <20160107071039.13648.55302.stgit@localhost.localdomain>
 <alpine.NEB.2.11.1601121001560.1772@chris.i8u.org>
Message-ID: <CAKgT0UdWEoxcs=J3c378ChNRZy8pfpXj0gq1cNiVv9o9GTvtBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 12, 2016 at 10:03 AM, Hisashi T Fujinaka <htodd@twofifty.com> wrote:
> Hey Alex, I have a question.
>
>
> On Wed, 6 Jan 2016, Alexander Duyck wrote:
>
>> Since the igb driver is using page based receive there is no point in
>> limiting the Rx capabilities of the device.  The driver can receive 9K
>> jumbo frames at all times.  The only changes needed due to MTU changes are
>> updates for the FIFO sizes and flow-control watermarks.
>>
>> Update the maximum frame size to reflect the 9.5K limitation of the
>> hardware, and replace all instances of max_frame_size with
>> MAX_JUMBO_FRAME_SIZE when referring to an Rx FIFO or frame.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>> drivers/net/ethernet/intel/igb/e1000_defines.h |    3 -
>> drivers/net/ethernet/intel/igb/igb_main.c      |  107
>> +++++++++---------------
>> 2 files changed, 42 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h
>> b/drivers/net/ethernet/intel/igb/e1000_defines.h
>> index e28f06e56f37..3e4181a4b177 100644
>> --- a/drivers/net/ethernet/intel/igb/e1000_defines.h
>> +++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
>> @@ -357,7 +357,8 @@
>> /* Ethertype field values */
>> #define ETHERNET_IEEE_VLAN_TYPE 0x8100  /* 802.3ac packet */
>>
>> -#define MAX_JUMBO_FRAME_SIZE    0x3F00
>> +/* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
>> +#define MAX_JUMBO_FRAME_SIZE    0x2600
>>
>> /* PBA constants */
>> #define E1000_PBA_32K 0x0020
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
>> b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 3b6d4e10d095..5b200c9f7658 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -1891,7 +1891,7 @@ void igb_reset(struct igb_adapter *adapter)
>>         struct e1000_hw *hw = &adapter->hw;
>>         struct e1000_mac_info *mac = &hw->mac;
>>         struct e1000_fc_info *fc = &hw->fc;
>> -       u32 pba = 0, tx_space, min_tx_space, min_rx_space, hwm;
>> +       u32 pba, hwm;
>>
>>         /* Repartition Pba for greater than 9k mtu
>>          * To take effect CTRL.RST is required.
>> @@ -1917,9 +1917,10 @@ void igb_reset(struct igb_adapter *adapter)
>>                 break;
>>         }
>>
>> -       if ((adapter->max_frame_size > ETH_FRAME_LEN + ETH_FCS_LEN) &&
>> -           (mac->type < e1000_82576)) {
>> -               /* adjust PBA for jumbo frames */
>> +       if (mac->type == e1000_82575) {
>> +               u32 min_rx_space, min_tx_space, needed_tx_space;
>> +
>> +               /* write Rx PBA so that hardware can report correct Tx PBA
>> */
>>                 wr32(E1000_PBA, pba);
>
>
> Aren't you writing a random pba here? Shouldn't it still be "pba = 0"  a
> few lines up?

If you take a look in the function there is a switch statement just
above where pba is set to 34K for the 82575.  There are no cases in
the switch statement where pba is not set.

- Alex
