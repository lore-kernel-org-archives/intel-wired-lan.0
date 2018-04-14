From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Apr 2018 02:22:52 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 08/10] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <20180410174959.18757-9-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-9-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83A1FB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> Sent: Tuesday, April 10, 2018 10:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>
> Subject: [next-queue PATCH v7 08/10] igb: Add MAC address support for
> ethtool nftuple filters
> 
> This adds the capability of configuring the queue steering of arriving
> packets based on their source and destination MAC addresses.
> 
> Source address steering (i.e. driving traffic to a specific queue),
> for the i210, does not work, but filtering does (i.e. accepting
> traffic based on the source address). So, trying to add a filter
> specifying only a source address will be an error.
> 
> In practical terms this adds support for the following use cases,
> characterized by these examples:
> 
> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
> to the RX queue 0)
> 
> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 \
>   	     	  	    	  proto 0x22f0 action 3
> (this will direct packets with source address "44:44:44:44:44:44" and
> ethertype 0x22f0 to the RX queue 3)
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 43 ++++++++++++++++++--
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 

Tested by: Aaron Brown <aaron.f.brown@intel.com>
