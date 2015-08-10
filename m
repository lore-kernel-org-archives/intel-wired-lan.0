From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:32:46 +0000
Subject: [Intel-wired-lan] [PATCH V5 01/19] ixgbe: Accept SFP not
 present	errors on all devices
In-Reply-To: <20150808231746.94784.29796.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231746.94784.29796.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F609@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 01/19] ixgbe: Accept SFP not present errors
> on all devices
> 
> When an SFP not present error is returned by the reset_hw method, accept it
> and go on, since an SFP can still be inserted. Previously it was only accepted for
> 82598 devices.
> 

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
