From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:34:55 +0000
Subject: [Intel-wired-lan] [PATCH V5 11/19] ixgbe: Add logic to reset
 CS4227	when needed
In-Reply-To: <20150808231838.94784.26142.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231838.94784.26142.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F6EB@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 11/19] ixgbe: Add logic to reset CS4227
> when needed
> 
> On some hardware platforms, the CS4227 does not initialize properly.
> Detect those cases and reset it appropriately.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> -----
> Change in V5:
> - Simplify end return of ixgbe_get_cs4227_status

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
