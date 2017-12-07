From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 7 Dec 2017 09:03:36 -0800
Subject: [Intel-wired-lan] [next-queue 02/10] ixgbe: add ipsec register
 access routines
In-Reply-To: <CAKgT0Uci9TLVcaYzfGr=yVXDhVc+sbQr01cUeWiypN7-7faYmw@mail.gmail.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-3-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0Ufx7m2eTZ8hQOX9dpEaNKozb85axCvS_e7RPAxTsm33MA@mail.gmail.com>
 <c03223ae-feae-8835-0e74-4f7c11856381@oracle.com>
 <CAKgT0Uci9TLVcaYzfGr=yVXDhVc+sbQr01cUeWiypN7-7faYmw@mail.gmail.com>
Message-ID: <96dda749-6c0d-3169-eb93-d4510fefcb7d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/2017 8:02 AM, Alexander Duyck wrote:
> On Wed, Dec 6, 2017 at 9:43 PM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Thanks, Alex, for your detailed comments, I do appreciate the time and
>> thought you put into them.
>>
>> Responses below...
>>
>> sln
>>
>> On 12/5/2017 8:56 AM, Alexander Duyck wrote:

<snip>

>>>> +       reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
>>>> +       reg &= IXGBE_RXTXIDX_IPS_EN;
>>>> +       reg |= tbl | idx << 3 | IXGBE_RXTXIDX_IDX_WRITE;
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
>>>> +       IXGBE_WRITE_FLUSH(hw);
>>>> +}
>>>> +
>>>
>>>
>>> The Rx version of this gets a bit trickier since the datasheet
>>> actually indicates there are a few different types of tables that can
>>> be indexed via this. Also why is the tbl value not being shifted? It
>>> seems like it should be shifted by 1 to avoid overwriting the IPS_EN
>>> bit. Really I would like to see the tbl value converted to an enum and
>>> shifted by 1 in order to generate the table reference.
>>
>>
>> I would have done this, but we can't use an enum shifted bit because the
>> field values are 01, 10, and 11.  I used the direct 2, 4, and 6 values
>> rather than shifting by one, but I can reset them and shift by 1.
> 
> I didn't mean 1 << enum I was referring to enum << 1. Right now you
> can be given a table value of 3 if somebody incorrectly used the
> function and the side effect is that it overwrites the enable bit.

Okay, sure, that makes sense.

> 
>>>

<snip>

>>>> +       /* store the SPI (in bigendian) and IPidx */
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, spi);
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
>>>> +       IXGBE_WRITE_FLUSH(hw);
>>>> +
>>>> +       ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_SPI);
>>>> +
>>>> +       /* store the key, salt, and mode */
>>>> +       for (i = 0; i < 4; i++)
>>>> +               IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(i),
>>>> cpu_to_be32(key[3-i]));
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, cpu_to_be32(salt));
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, mode);
>>>> +       IXGBE_WRITE_FLUSH(hw);
>>>> +
>>>> +       ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_KEY);
>>>> +}
>>>
>>>
>>> Is there any reason why you could write the SPI, key, salt, and mode,
>>> then flush, and trigger the writes via the IPSRXIDX? Just wondering
>>> since it would likely save you a few cycles avoiding PCIe bus stalls.
>>
>>
>> See note above about religiously flushing everything to make a persnickety
>> chip work.
> 
> I get the flushing. What I am saying is that as far as I can tell the
> SPI, salt, and mode don't overlap so you could update all 3, flush,
> and then call set_rx_item twice.

I'll check that for here and a possibly a couple other places.

> 
>>>
>>>
>>>> +
>>>> +/**
>>>> + * ixgbe_ipsec_set_rx_ip - set up the register bits to save SA IP addr
>>>> info
>>>> + * @hw: hw specific details
>>>> + * @idx: register index to write
>>>> + * @addr: IP address byte array
>>>> + **/
>>>> +static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, u32
>>>> addr[])
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       /* store the ip address */
>>>> +       for (i = 0; i < 4; i++)
>>>> +               IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(i), addr[i]);
>>>> +       IXGBE_WRITE_FLUSH(hw);
>>>> +
>>>> +       ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_IP);
>>>> +}
>>>> +
>>>
>>>
>>> This piece is kind of confusing. I would suggest storing the address
>>> as a __be32 pointer instead of a u32 array. That way you start with
>>> either an IPv6 or an IPv4 address at offset 0 instead of the way the
>>> hardware is defined which has you writing it at either 0 or 3
>>> depending on if the address is IPv6 or IPv4.
>>
>>
>> Using a __be32 rather than u32 is fine here, it doesn't make much
>> difference.
>>
>> If I understand your suggestion correctly, we would also need an additional
>> function parameter to tell us if we were pointing to an ipv6 or ipv4
>> address.  Since the driver's SW tables are modeling the HW, I think it is
>> simpler to leave it in the array.
> 
> Actually I am not too concerned about needing a flag, but the __be32
> usage addresses another problem. If I am not mistaken in order to
> store an IPv6 value you will have to write addr[3] to IPADDR(0) and so
> forth since the hardware is storing the IPv6 address as little endian.
> So if you store the IPv4 address in addr[0] as a __be32 value and
> leave the rest as zero you should get the correct ordering in either
> setup when you store either IPv6 or IPv4 values.

The datasheet says
   n=0 contains the MSB for an IPv6 IP Address.
   n=3 contains an IPv4 IP Address or the LSB for an IPv6 IP Address.
If the ipv6 address is handed to us in bigendian, then I think we're okay.

Obviously this is something that will get tested when I get around to 
fixing up support for ipv6 in the future, and perhaps I'll be surprised.

sln
