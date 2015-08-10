From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 10 Aug 2015 23:34:29 +0000
Subject: [Intel-wired-lan] [PATCH V5 09/19] ixgbe: Add X550EM_x
 dual-speed	SFP+ support
In-Reply-To: <20150808231828.94784.75423.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
 <20150808231828.94784.75423.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9F6B9@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 09/19] ixgbe: Add X550EM_x dual-speed
> SFP+ support
> 
> This patch adds X550EM_x SFP+ dual-speed support. 82599 fiber link code was
> moved from ixgbe_82599.c to ixgbe_common.c for use by X550EM. SFP MAC
> link code is added to x550EM.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V4:
> - Added omitted NULL check on flap_tx_laser method calls

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
