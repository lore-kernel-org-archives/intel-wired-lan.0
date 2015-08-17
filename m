From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 17 Aug 2015 21:16:18 +0000
Subject: [Intel-wired-lan] [PATCH V4 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <20150615183320.98036.13921.stgit@mdrustad-wks.jf.intel.com>
References: <20150615182643.98036.77888.stgit@mdrustad-wks.jf.intel.com>
 <20150615183320.98036.13921.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180BA1A68@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V4 1/2] ixgbe: Add support for UDP-
> encapsulated tx checksum offload
> 
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> By using GSO for UDP-encapsulated packets, all ixgbe devices can be directed to
> generate checksums for the inner headers because the outer UDP checksum can
> be zero. So point the machinery at the inner headers and have the hardware
> generate the checksum.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
