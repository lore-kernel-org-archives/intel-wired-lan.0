From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 10 May 2018 13:37:17 -0700
Subject: [Intel-wired-lan] [PATCH v6 4/5] ixgbe: Report PCIe link
 properties with pcie_print_link_status()
In-Reply-To: <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <182a863cd7502dd9d872beb5265487a4ce39453d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-05-03 at 15:00 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously the driver used pcie_get_minimum_link() to warn when the
> NIC
> is in a slot that can't supply as much bandwidth as the NIC could
> use.
> 
> pcie_get_minimum_link() can be misleading because it finds the
> slowest link
> and the narrowest link (which may be different links) without
> considering
> the total bandwidth of each link.  For a path with a 16 GT/s x1 link
> and a
> 2.5 GT/s x16 link, it returns 2.5 GT/s x1, which corresponds to 250
> MB/s of
> bandwidth, not the true available bandwidth of about 1969 MB/s for a
> 16 GT/s x1 link.
> 
> Use pcie_print_link_status() to report PCIe link speed and possible
> limitations instead of implementing this in the driver itself.  This
> finds
> the slowest link in the path to the device by computing the total
> bandwidth
> of each link and compares that with the capabilities of the device.
> 
> The dmesg change is:
> 
>   - PCI Express bandwidth of %dGT/s available
>   - (Speed:%s, Width: x%d, Encoding Loss:%s)
>   + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)
> 
> or, if the device is capable of better performance than is available
> in the
> current slot:
> 
>   - This is not sufficient for optimal performance of this card.
>   - For optimal performance, at least %dGT/s of bandwidth is
> required.
>   - A slot with more lanes and/or higher speed is suggested.
>   + %u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at
> %s (capable of %u.%03u Gb/s with %s x%d link)
> 
> Note that the driver previously used dev_warn() to suggest using a
> different slot, but pcie_print_link_status() uses dev_info() because
> if the
> platform has no faster slot available, the user can't do anything
> about the
> warning and may not want to be bothered with it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Since this is apart of a series, I am not planning to pick this up and
push to David Miller in my ixgbe updates.  This should remain in the
series so David can pick up the entire series at once.

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   47 +------------
> ------------
>  1 file changed, 1 insertion(+), 46 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180510/55ea0ff3/attachment.asc>
