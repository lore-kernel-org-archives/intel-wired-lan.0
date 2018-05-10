From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 May 2018 19:12:54 +0000
Subject: [Intel-wired-lan] [PATCH v6 4/5] ixgbe: Report PCIe link
 properties with pcie_print_link_status()
In-Reply-To: <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B763F09@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bjorn Helgaas
> Sent: Thursday, May 3, 2018 1:01 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Ganesh Goudar
> <ganeshgr@chelsio.com>; Michael Chan <michael.chan@broadcom.com>;
> Ariel Elior <ariel.elior@cavium.com>
> Cc: Jakub Kicinski <kubakici@wp.pl>; linux-pci at vger.kernel.org; linux-
> kernel at vger.kernel.org; Tal Gilboa <talgi@mellanox.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; everest-linux-
> l2 at cavium.com; Tariq Toukan <tariqt@mellanox.com>
> Subject: [Intel-wired-lan] [PATCH v6 4/5] ixgbe: Report PCIe link properties
> with pcie_print_link_status()
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously the driver used pcie_get_minimum_link() to warn when the NIC is
> in a slot that can't supply as much bandwidth as the NIC could use.
> 
> pcie_get_minimum_link() can be misleading because it finds the slowest link
> and the narrowest link (which may be different links) without considering the
> total bandwidth of each link.  For a path with a 16 GT/s x1 link and a
> 2.5 GT/s x16 link, it returns 2.5 GT/s x1, which corresponds to 250 MB/s of
> bandwidth, not the true available bandwidth of about 1969 MB/s for a
> 16 GT/s x1 link.
> 
> Use pcie_print_link_status() to report PCIe link speed and possible
> limitations instead of implementing this in the driver itself.  This finds the
> slowest link in the path to the device by computing the total bandwidth of
> each link and compares that with the capabilities of the device.
> 
> The dmesg change is:
> 
>   - PCI Express bandwidth of %dGT/s available
>   - (Speed:%s, Width: x%d, Encoding Loss:%s)
>   + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)
> 
> or, if the device is capable of better performance than is available in the
> current slot:
> 
>   - This is not sufficient for optimal performance of this card.
>   - For optimal performance, at least %dGT/s of bandwidth is required.
>   - A slot with more lanes and/or higher speed is suggested.
>   + %u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s
> (capable of %u.%03u Gb/s with %s x%d link)
> 
> Note that the driver previously used dev_warn() to suggest using a different
> slot, but pcie_print_link_status() uses dev_info() because if the platform has
> no faster slot available, the user can't do anything about the warning and
> may not want to be bothered with it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   47 +------------------------
>  1 file changed, 1 insertion(+), 46 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


