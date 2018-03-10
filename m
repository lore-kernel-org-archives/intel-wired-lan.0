From: David Miller <davem@davemloft.net>
Date: Fri, 09 Mar 2018 21:35:30 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180309151428.4d73358c@cakuba.netronome.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
Message-ID: <20180309.213530.1626774036306871787.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jakub Kicinski <kubakici@wp.pl>
Date: Fri, 9 Mar 2018 15:14:28 -0800

> On Fri,  9 Mar 2018 09:21:33 -0800, Anirudh Venkataramanan wrote:
>> +static const struct ice_stats ice_net_stats[] = {
>> +	ICE_NETDEV_STAT(rx_packets),
>> +	ICE_NETDEV_STAT(tx_packets),
>> +	ICE_NETDEV_STAT(rx_bytes),
>> +	ICE_NETDEV_STAT(tx_bytes),
>> +	ICE_NETDEV_STAT(rx_errors),
>> +	ICE_NETDEV_STAT(tx_errors),
>> +	ICE_NETDEV_STAT(rx_dropped),
>> +	ICE_NETDEV_STAT(tx_dropped),
>> +	ICE_NETDEV_STAT(multicast),
>> +	ICE_NETDEV_STAT(rx_length_errors),
>> +	ICE_NETDEV_STAT(rx_crc_errors),
>> +};
> 
> Please don't duplicate standard netdev stats in ethtool -S.

Indeed, unless you are providing per-queue versions of these
stats, don't do this.
