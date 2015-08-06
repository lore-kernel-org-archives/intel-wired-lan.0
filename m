From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 6 Aug 2015 17:44:27 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remove unused PCI
	bus	types
In-Reply-To: <20150618203142.5055.31733.stgit@dcs-desk.jf.intel.com>
References: <20150618203142.5055.31733.stgit@dcs-desk.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9DDFC@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Thursday, June 18, 2015 1:32 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remove unused PCI bus types
> 
> The ixgbe never has as very doubtfully ever will support either PCI or PCI-X
> devices.  So remove the unused types from the ixgbe_bus_type.  Thanks to Alex
> Duyck for suggesting this.
> 
> Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
