From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 6 Aug 2015 17:46:42 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add new bus type for
 intergrated I/O interface (IOSF)
In-Reply-To: <20150618172406.28298.88836.stgit@dcs-desk.jf.intel.com>
References: <20150618172406.28298.88836.stgit@dcs-desk.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9DE27@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Thursday, June 18, 2015 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add new bus type for
> intergrated I/O interface (IOSF)
> 
> With this patch we add support for a new bus type ixgbe_bus_type_internal.
> X550em devices use IOSF and not PCIe bus so this new type is to accommodate
> them.
> 
> Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
