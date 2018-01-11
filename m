From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Thu, 11 Jan 2018 23:17:48 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use only 3k Rx buffers for
 82599 with build_skb
In-Reply-To: <CAKgT0UctWKCzmcV3HBG-qeGKq=jUFrpXxMMhbVV9JkxAgskTSQ@mail.gmail.com>
References: <20180111210602.28743.57326.stgit@localhost6.localdomain6>
 <CAKgT0UctWKCzmcV3HBG-qeGKq=jUFrpXxMMhbVV9JkxAgskTSQ@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992B40E50D5@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>Sent: Thursday, January 11, 2018 1:56 PM
>To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
>Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: use only 3k Rx buffers for
>82599 with build_skb
>
>On Thu, Jan 11, 2018 at 1:06 PM, Emil Tantilov
><emil.s.tantilov@intel.com> wrote:
>> commit 2de6aa3a666e ("ixgbe: Add support for padding packet")
>>
>> Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using
>build_skb.
>> Unfortunately that register does not work on 82599, so we are forcing
>3k
>> buffers for that MAC.
>>
>> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 722cc31..be2dd56 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -4133,7 +4133,8 @@ void ixgbe_configure_rx_ring(struct
>ixgbe_adapter *adapter,
>>                 rxdctl &= ~0x3FFFFF;
>>                 rxdctl |=  0x080420;
>>  #if (PAGE_SIZE < 8192)
>> -       } else {
>> +       /* RXDCTL.RLPML does not work on 82599 */
>> +       } else if (hw->mac.type != ixgbe_mac_82599EB){
>>                 rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
>>                             IXGBE_RXDCTL_RLPML_EN);
>>
>
>This change doesn't make sense. We aren't enablling RLPML here we are
>disabling it. Disabling it should work the same for 82599 just like it
>would for any of the other parts in this family.
True, but the only reason this code was added (from what I can tell) is
to clear the bits in case we end up enabling it in the condition below.

We don't use RXDCTL.RLPML/_EN anywhere else and it defaults to 0, so this
entire section would not apply to 82599 which is why I added the check.

>> @@ -4305,6 +4306,8 @@ static void ixgbe_set_rx_buffer_len(struct
>ixgbe_adapter *adapter)
>>                         continue;
>>
>>                 set_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &rx_ring-
>>state);
>> +               if (hw->mac.type == ixgbe_mac_82599EB)
>> +                       set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring-
>>state);
>>
>>  #if (PAGE_SIZE < 8192)
>>                 if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
>
>I think this bit is redundant. We aren't using the ring RLPML for
>this. My understanding as I recall is that we are using the maximum
>frame size allowed on the MAC to limit the frame size on 82599. That
>is why if we switch to jumbo frames at the end of this call we are
>switching to 3K mode already.

Yes, but I thought the point was to use this in case where we do not
have jumbo frames enabled. Otherwise what is the point of adding the
RLPML limit? The MAXFRS will protect 82599 and above equally.

Thanks,
Emil
