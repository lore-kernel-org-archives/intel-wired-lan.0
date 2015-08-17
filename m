From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 17 Aug 2015 21:17:00 +0000
Subject: [Intel-wired-lan] [PATCH V4 2/2] ixgbe: Add support for VXLAN
 RX	offloads
In-Reply-To: <20150615183325.98036.686.stgit@mdrustad-wks.jf.intel.com>
References: <20150615182643.98036.77888.stgit@mdrustad-wks.jf.intel.com>
 <20150615183325.98036.686.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180BA1A83@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, June 15, 2015 11:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V4 2/2] ixgbe: Add support for VXLAN RX
> offloads
> 
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> Add support for VXLAN RX offloads for the X55x devices that support them.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V3:
> - change __constant_htons to simply htons 

Changes in V4:
> - add static to ixgbe_clear_vxlan_port
> - use ixgbe_clear_vxlan_port to clear vxlan port
> - call ixgbe_clear_vxlan_port when turning checksum offload off
> ---


Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
