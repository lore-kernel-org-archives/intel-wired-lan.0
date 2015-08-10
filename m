From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:35:33 +0000
Subject: [Intel-wired-lan] [PATCH V5 14/19] ixgbe: Add I2C bus mux
 support
In-Reply-To: <20150808231853.94784.19157.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231853.94784.19157.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F738@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Saturday, August 08, 2015 4:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 14/19] ixgbe: Add I2C bus mux support
> 
> Take control of an I2C mux that selects which SFP is attached to the I2C bus. The
> control of the mux is captured in the taking and releasing of the related
> semaphore. Because only port 1 can control the mux, port 1 always leaves the
> mux set to select port 0.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
