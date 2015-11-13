From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 13 Nov 2015 20:54:43 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Handle extended IPv6 headers
 in	tx path
In-Reply-To: <20151107003621.85794.6437.stgit@mdrustad-wks.jf.intel.com>
References: <20151107003621.85794.6437.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180C17A4E@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, November 06, 2015 4:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Handle extended IPv6 headers in tx
> path
> 
> Check for and handle IPv6 extended headers so that tx checksum offload can be
> done. Thanks to Tom Herbert for noticing this problem. Note that the goto back
> to process the final protocol value can never result in a loop, because it cannot
> be yet another extended header. Handling them in this manner avoids adding
> further checks to the non-extended header hot path.
> 
> Reported-by: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
