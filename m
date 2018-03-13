From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 13 Mar 2018 12:17:10 -0700
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <1520967916.696.21.camel@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
 <1520967916.696.21.camel@intel.com>
Message-ID: <a6f3bd20-705e-2022-23c8-1e3b5a8c93a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 03/13/2018 12:05 PM, Venkataramanan, Anirudh wrote:
> On Fri, 2018-03-09 at 15:14 -0800, Jakub Kicinski wrote:
>> On Fri,  9 Mar 2018 09:21:33 -0800, Anirudh Venkataramanan wrote:
>>> +static const struct ice_stats ice_net_stats[] = {
>>> +	ICE_NETDEV_STAT(rx_packets),
>>> +	ICE_NETDEV_STAT(tx_packets),
>>> +	ICE_NETDEV_STAT(rx_bytes),
>>> +	ICE_NETDEV_STAT(tx_bytes),
>>> +	ICE_NETDEV_STAT(rx_errors),
>>> +	ICE_NETDEV_STAT(tx_errors),
>>> +	ICE_NETDEV_STAT(rx_dropped),
>>> +	ICE_NETDEV_STAT(tx_dropped),
>>> +	ICE_NETDEV_STAT(multicast),
>>> +	ICE_NETDEV_STAT(rx_length_errors),
>>> +	ICE_NETDEV_STAT(rx_crc_errors),
>>> +};
>>
>> Please don't duplicate standard netdev stats in ethtool -S.
> 
> Jacub,
> 
> Thanks for the feedback. I am not sure I understand what's being asked
> here. Do you mean to say that standard netdev stats should not be
> printed when we do ethtool -S or something else?
> 
> Thanks!
> Ani
> 

Yes, this is a recurring mistake

See commit
bf909456f6a89654cb65c01fe83a4f9b133bf978 Revert "net: hns3: Add packet 
statistics of netdev"
