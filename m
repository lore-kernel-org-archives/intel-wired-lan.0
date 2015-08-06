From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 6 Aug 2015 17:38:56 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add get_bus_info
 method	for X550
In-Reply-To: <20150618005959.27460.11244.stgit@dcs-desk.jf.intel.com>
References: <20150618005959.27460.11244.stgit@dcs-desk.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9DDBD@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, June 17, 2015 6:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add get_bus_info method for
> X550
> 
> From: Don Skidmore <donald.c.skidmore@intel.com>
> 
> Added ixgbe_get_bus_info_X550em to X550 code. ixgbe_get_bus_info_X550em
> sets bus.width to ixgbe_bus_width_unknown and bus.speed to
> ixgbe_bus_speed_unknown, because IOSF does not report a PCIe bus width or
> speed.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

