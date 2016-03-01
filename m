From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 17:35:36 +0000
Subject: [Intel-wired-lan] [next PATCH v2 2/4] ixgbevf: Add support
	for	generic Tx checksums
In-Reply-To: <20160113153117.4527.6404.stgit@localhost.localdomain>
References: <20160113153001.4527.91152.stgit@localhost.localdomain>
 <20160113153117.4527.6404.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99B0EB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, January 13, 2016 7:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH v2 2/4] ixgbevf: Add support for
> generic Tx checksums
> 
> This patch adds support for generic Tx checksums to the ixgbevf driver.  It
> turns out this is actually pretty easy after going over the datasheet as we
> were doing a number of steps we didn't need to.
> 
> In order to perform a Tx checksum for an L4 header we need to fill in the
> following fields in the Tx descriptor:
>   MACLEN (maximum of 127), retrieved from:
> 		skb_network_offset()
>   IPLEN  (maximum of 511), retrieved from:
> 		skb_checksum_start_offset() - skb_network_offset()
>   TUCMD.L4T indicates offset and if checksum or crc32c, based on:
> 		skb->csum_offset
> 
> The added advantage to doing this is that we can support inner checksum
> offloads for tunnels and MPLS while still being able to transparently insert
> VLAN tags.
> 
> I also took the opportunity to clean-up many of the feature flag configuration
> bits to make them a bit more consistent between drivers.  In the case of the
> VF drivers this meant adding support for SCTP CRCs, and inner checksum
> offloads for MPLS and various tunnel types.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  104 +++++++++--------
> ----
>  1 file changed, 43 insertions(+), 61 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool shows generic checksum offload support, can be toggled.
