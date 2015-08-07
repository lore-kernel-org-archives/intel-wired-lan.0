From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 7 Aug 2015 19:46:06 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Simplify port-specific
 macros
In-Reply-To: <20150606174103.45169.64009.stgit@mdrustad-wks.jf.intel.com>
References: <20150606174103.45169.64009.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9E746@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Saturday, June 06, 2015 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Simplify port-specific macros
> 
> Simplify port-specific macros by eliminating explicit comparison with 0. More
> importantly, enclose formal parameter in parens to eliminate the risk of an
> operator precedence surprise.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Corrected typo in log message
> - Updated Copyright year in the file header

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
