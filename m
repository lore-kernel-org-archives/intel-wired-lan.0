From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:33:27 +0000
Subject: [Intel-wired-lan] [PATCH V5 04/19] ixgbe: Provide unlocked
	I2C	methods
In-Reply-To: <20150808231802.94784.12420.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231802.94784.12420.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F634@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 04/19] ixgbe: Provide unlocked I2C
> methods
> 
> Most I2C accesses take and release semaphores for each access. Now there is a
> reason to perform multiple I2C operations under the same holding of the
> semaphore, so provide unlocked I2C methods for that purpose.
> 

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
