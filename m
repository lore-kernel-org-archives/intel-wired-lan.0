From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Apr 2015 03:20:18 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/3] igb: move
 initialization of link properties before igb_sw_init
In-Reply-To: <1428707018-6405-2-git-send-email-jtoppins@cumulusnetworks.com>
References: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1428707018-6405-2-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBB061@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jonathan Toppins
> Sent: Friday, April 10, 2015 4:04 PM
> To: Kirsher, Jeffrey T
> Cc: Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
> C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; gospo at cumulusnetworks.com;
> shm at cumulusnetworks.com
> Subject: [PATCH v1 net-next 2/3] igb: move initialization of link
> properties before igb_sw_init
> 
> This is required otherwise the driver may experience a NULL ptr
> dereference if CONFIG_PCI_IOV is set to yes.
> 
> Since the code can follow the flow on init (driver insmod):
> 	hw->mac.autoneg = false; (this is not set it is its default)
> 	igb_probe()
> 	+- igb_sw_init()
> 	    +- igb_probe_vfs()
> 	        +- igb_pci_enable_sriov()
> 	            +- igb_sriov_reinit()
> 	               +- igb_reset()
> 	                  trimmed path is the same see call path for
> 	                  igb_reset below
> 	+- hw->mac.autoneg = true;
> 	+- igb_reset()
> 
> 	/* igb_reset() call chain */
> 	igb_reset()
> 	+- hw->mac.ops.init_hw() == igb_init_hw_82575
> 	   +- igb_setup_link()
> 	      +- hw->mac.ops.setup_physical_interface() ==
> 	           igb_setup_copper_link_82575()
> 	         +- igb_setup_copper_link()
> 	            +- possible NULL dereference
> 
> Pseudo code from igb_setup_copper_link():
> 	if (hw->mac.autoneg) {
> 	    /* setup link */
> 	} else {
> 	    hw->phy.ops.force_speed_duplex(hw);  // <-- NULL deref here
> 	}
> 
> Since the way the current code is designed the driver will call
> igb_setup_copper_link twice if SRIOV is configured to be enabled. The
> call will occur once with autoneg == false and the second
> time autoneg == true. Since the decision to call the function pointer
> (hw->phy.ops.force_speed_duplex) is predicated on autoneg being set
> correctly move the setting of these parameters to as early as possible
> in the probe function.
> 
> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
