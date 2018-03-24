From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 24 Mar 2018 03:40:29 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <20180322003353.29970-8-vinicius.gomes@intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
 <20180322003353.29970-8-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C81BBB3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Vinicius Costa Gomes
> Sent: Wednesday, March 21, 2018 5:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC address
> support for ethtool nftuple filters
> 
> This adds the capability of configuring the queue steering of arriving
> packets based on their source and destination MAC addresses.
> 
> In practical terms this adds support for the following use cases,
> characterized by these examples:
> 
> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
> to the RX queue 0)
> 
> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
> (this will direct packets with source address "44:44:44:44:44:44" to
> the RX queue 3)
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 35
> ++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)

Maybe not "this" patch, but this is the one that enables the ethtool commands, so replying here.
The filters do not seem to take effect with this version (v5) of the series.  The commands are accepted for i210 and rejected with unsupported messages for the other adapters (as desired) and an ethtool -n shows the filter, however, with either the src or dst filter set I can run traffic (netperf) that should be caught by the filter and rather than being directed to the single queue it is spread across queues as would be expected without the filter set.

The test system still has a kernel / driver with the v4 series of this patch set and the exact same filter commands / system setup does filter the traffic to the specified rx queue with the v4 series.
