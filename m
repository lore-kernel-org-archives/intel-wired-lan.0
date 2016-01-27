From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 27 Jan 2016 21:09:01 +0000
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Fix flow control for Xeon D
 KR	backplane
In-Reply-To: <20160126003210.115571.29526.stgit@mdrustad-wks.jf.intel.com>
References: <20160126003210.115571.29526.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D28677@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, January 25, 2016 4:32 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Fix flow control for Xeon D KR
> backplane
> 
> Xeon D KR backplane is different from other backplanes, in that we can't use
> auto-negotiation to determine the mode. Instead, use whatever the user
> configured.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Only apply new fc setup function for BDX-DE KR backplane Changes in V3:
> - Don't use product codename

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
