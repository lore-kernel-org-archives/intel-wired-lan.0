From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:34:41 +0000
Subject: [Intel-wired-lan] [PATCH V5 10/19] ixgbe: Fix 1G and 10G link
 stability for X550EM_x SFP+
In-Reply-To: <20150808231833.94784.77582.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231833.94784.77582.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F6C7@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 10/19] ixgbe: Fix 1G and 10G link stability
> for X550EM_x SFP+
> 
> Configures the CS4227 correctly for both 1G and 10G operation, by moving the
> code to ixgbe_setup_mac_link_sfp_x550em(). It needs to be in this function
> because we need both the module type and the speed, and this is the only
> function in the init flow that knows the speed. In contrast,
> ixgbe_setup_sfp_modules_X550em() does not know the speed, so we can't do
> anything useful here. This is a fundamental difference from the previous flow,
> and is due to the way the CS4227 is implemented.
> 

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
