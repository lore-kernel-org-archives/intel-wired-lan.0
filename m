From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:34:10 +0000
Subject: [Intel-wired-lan] [PATCH V5 08/19] ixgbe: Allow reduced
	delays	during sfp detection
In-Reply-To: <20150808231822.94784.46874.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231822.94784.46874.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F697@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 08/19] ixgbe: Allow reduced delays during
> sfp detection
> 
> Reduce the number of retries during phy detection. This reduces pauses when no
> SFP is present. Once an SFP is detected, the normal retry count will be used.
> 


Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
