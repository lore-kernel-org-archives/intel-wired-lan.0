From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 14 Aug 2015 15:26:24 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Check whether FDIRCMD
 writes	actually complete
In-Reply-To: <20150611180220.98698.69987.stgit@mdrustad-wks.jf.intel.com>
References: <20150611180220.98698.69987.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180BA1055@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Thursday, June 11, 2015 11:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Check whether FDIRCMD writes
> actually complete
> 
> Wait up to about 100 us for FDIRCMD writes to complete and return failure
> indications.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
