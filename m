From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:36:22 +0000
Subject: [Intel-wired-lan] [PATCH V5 18/19] ixgbe: Update
 ixgbe_disable_pcie_master flow for X550*
In-Reply-To: <20150808231914.94784.69679.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231914.94784.69679.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F79A@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 18/19] ixgbe: Update
> ixgbe_disable_pcie_master flow for X550*
> 
> This patch skips the PCI transactions pending check in
> ixgbe_disable_pcie_master. This is done to addresses a known HW issue where
> the PCI transactions pending bit sticks high when there are pending transactions.
> HW engineering instructed to workaround this issue by wait and then continue
> with our reset flow.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
