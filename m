From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:33:52 +0000
Subject: [Intel-wired-lan] [PATCH V5 06/19] ixgbe: Enable bit-banging
 mode	on X550
In-Reply-To: <20150808231812.94784.1540.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231812.94784.1540.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F682@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Saturday, August 08, 2015 4:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 06/19] ixgbe: Enable bit-banging mode on
> X550
> 
> Set the bit banging mode in the hardware when performing bit banging I2C
> operations on X550. Also control the output enable on both the clock and data
> lines.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
