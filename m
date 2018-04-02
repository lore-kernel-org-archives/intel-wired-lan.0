From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 2 Apr 2018 15:31:44 -0500
Subject: [Intel-wired-lan] [PATCH v5 12/14] fm10k: Report PCIe link
 properties with pcie_print_link_status()
In-Reply-To: <02874ECE860811409154E81DA85FBB5882D497EE@ORSMSX115.amr.corp.intel.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244397259.135666.12655029447932912161.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D497EE@ORSMSX115.amr.corp.intel.com>
Message-ID: <20180402203144.GM9322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Apr 02, 2018 at 03:56:06PM +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> > Sent: Friday, March 30, 2018 2:06 PM
> > To: Tal Gilboa <talgi@mellanox.com>
> > Cc: Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>; Ganesh
> > Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; everest-linux-l2 at cavium.com; intel-wired-
> > lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> > linux-pci at vger.kernel.org
> > Subject: [PATCH v5 12/14] fm10k: Report PCIe link properties with
> > pcie_print_link_status()
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Use pcie_print_link_status() to report PCIe link speed and possible
> > limitations instead of implementing this in the driver itself.
> > 
> > Note that pcie_get_minimum_link() can return misleading information because
> > it finds the slowest link and the narrowest link without considering the
> > total bandwidth of the link.  If the path contains a 16 GT/s x1 link and a
> > 2.5 GT/s x16 link, pcie_get_minimum_link() returns 2.5 GT/s x1, which
> > corresponds to 250 MB/s of bandwidth, not the actual available bandwidth of
> > about 2000 MB/s for a 16 GT/s x1 link.
> 
> This comment is about what's being fixed, so it would have been easier to
> parse if it were written to more clearly indicate that we're removing
> (and not adding) this behavior.

Good point.  Is this any better?

  fm10k: Report PCIe link properties with pcie_print_link_status()
  
  Previously the driver used pcie_get_minimum_link() to warn when the NIC
  is in a slot that can't supply as much bandwidth as the NIC could use.
  
  pcie_get_minimum_link() can be misleading because it finds the slowest link
  and the narrowest link (which may be different links) without considering
  the total bandwidth of each link.  For a path with a 16 GT/s x1 link and a
  2.5 GT/s x16 link, it returns 2.5 GT/s x1, which corresponds to 250 MB/s of
  bandwidth, not the true available bandwidth of about 1969 MB/s for a
  16 GT/s x1 link.
  
  Use pcie_print_link_status() to report PCIe link speed and possible
  limitations instead of implementing this in the driver itself.  This finds
  the slowest link in the path to the device by computing the total bandwidth
  of each link and compares that with the capabilities of the device.
  
  Note that the driver previously used dev_warn() to suggest using a
  different slot, but pcie_print_link_status() uses dev_info() because if the
  platform has no faster slot available, the user can't do anything about the
  warning and may not want to be bothered with it.
