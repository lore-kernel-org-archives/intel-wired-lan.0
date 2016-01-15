From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Jan 2016 03:22:11 +0000
Subject: [Intel-wired-lan] [next PATCH v2 3/4] igb: Add support for
 generic	Tx checksums
In-Reply-To: <20160113153123.4527.81111.stgit@localhost.localdomain>
References: <20160113153001.4527.91152.stgit@localhost.localdomain>,
 <20160113153123.4527.81111.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F920@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 13, 2016 7:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH v2 3/4] igb: Add support for generic     Tx checksums
> 
> This patch adds support for generic Tx checksums to the igb driver.  It
> turns out this is actually pretty easy after going over the datasheet as we
> were doing a number of steps we didn't need to.
> 
> In order to perform a Tx checksum for an L4 header we need to fill in the
> following fields in the Tx descriptor:
>   MACLEN (maximum of 127), retrieved from:
>                 skb_network_offset()
>   IPLEN  (maximum of 511), retrieved from:
>                 skb_checksum_start_offset() - skb_network_offset()
>   TUCMD.L4T indicates offset and if checksum or crc32c, based on:
>                 skb->csum_offset
> 
> The added advantage to doing this is that we can support inner checksum
> offloads for tunnels and MPLS while still being able to transparently
> insert VLAN tags.
> 
> I also took the opportunity to clean-up many of the feature flag
> configuration bits to make them a bit more consistent between drivers.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |  114 ++++++++++++-----------------
>  1 file changed, 47 insertions(+), 67 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
