From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 17:50:10 -0700
Subject: [Intel-wired-lan] [PATCH v2 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180315165247.165ac10e@xeon-e3>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-13-anirudh.venkataramanan@intel.com>
 <20180315165247.165ac10e@xeon-e3>
Message-ID: <CAKgT0UcpfznPj5S5sBwMnC0WPhDaMnFJnQqS3_EMb5tZr10wAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 15, 2018 at 4:52 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Thu, 15 Mar 2018 16:47:59 -0700
> Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> wrote:
>
>> +
>> +static const struct ice_stats ice_gstrings_vsi_stats[] = {
>> +     ICE_VSI_STAT("tx_unicast", eth_stats.tx_unicast),
>> +     ICE_VSI_STAT("rx_unicast", eth_stats.rx_unicast),
>> +     ICE_VSI_STAT("tx_multicast", eth_stats.tx_multicast),
>> +     ICE_VSI_STAT("rx_multicast", eth_stats.rx_multicast),
>> +     ICE_VSI_STAT("tx_broadcast", eth_stats.tx_broadcast),
>> +     ICE_VSI_STAT("rx_broadcast", eth_stats.rx_broadcast),
>> +     ICE_VSI_STAT("tx_bytes", eth_stats.tx_bytes),
>> +     ICE_VSI_STAT("rx_bytes", eth_stats.rx_bytes),
>> +     ICE_VSI_STAT("rx_discards", eth_stats.rx_discards),
>> +     ICE_VSI_STAT("tx_errors", eth_stats.tx_errors),
>> +     ICE_VSI_STAT("tx_linearize", tx_linearize),
>> +     ICE_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
>> +     ICE_VSI_STAT("rx_alloc_fail", rx_buf_failed),
>> +     ICE_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
>> +};
>> +
>
> Ignoring feedback from maintainers is unlikely to help get your driver adopted.

Your feedback wasn't ignored, the netdev stats are gone. I double
checked and there was this in addition to the netdev stats before so I
think the suggestion to remove the netdev stats was just taken
literally.

The VSI is a slightly different entity from the netdev itself. A
netdev can be backed by a VSI in the case of the PF, but the VSI can
be used in other ways such as what we did in i40e where we were using
it to spawn queue groups to work with mqprio as a filter target and in
that case the queue groups wouldn't have a netdev directly associated
with them so in that case it might make sense to leave these as
separate stats.

- Alex
