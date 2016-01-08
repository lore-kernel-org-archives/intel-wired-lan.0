From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 8 Jan 2016 01:17:57 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Make ATR recognize IPv6
 extended	headers
In-Reply-To: <20151209225537.130683.66320.stgit@mdrustad-wks.jf.intel.com>
References: <20151209225537.130683.66320.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D13FCF@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, December 09, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Make ATR recognize IPv6 extended
> headers
> 
> Right now ATR is not handling IPv6 extended headers, so ATR is not being
> performed on such packets. Fix that by skipping extended headers when they are
> present. This also fixes a problem where the ATR code was not checking that the
> inner protocol was actually TCP before setting up the signature rules. Since the
> protocol check is intimately involved with the extended header processing as
> well, this all gets fixed together.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
