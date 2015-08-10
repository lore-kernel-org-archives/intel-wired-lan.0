From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:35:19 +0000
Subject: [Intel-wired-lan] [PATCH V5 13/19] ixgbe: Limit SFP polling rate
In-Reply-To: <20150808231848.94784.92209.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231848.94784.92209.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F718@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 13/19] ixgbe: Limit SFP polling rate
> 
> Reduce the frequency of polling for SFP modules. Because the service task
> sometimes runs at high rates, we can poll for SFPs too often. When an SFP is not
> present, the I2C timeouts that result are very costly. So, prevent SFP polling from
> being done more than once every two seconds. To reduce latency, the poll time
> is cleared in a couple of cases to permit the next service task execution to poll
> the SFP module.
> 

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
