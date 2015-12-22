From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 22 Dec 2015 23:11:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550EM_x revision check
In-Reply-To: <20151120211217.98450.66003.stgit@mdrustad-wks.jf.intel.com>
References: <20151120211217.98450.66003.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFAE7F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, November 20, 2015 1:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550EM_x revision check
> 
> The X550EM_x revision check needs to check a value, not just a bit.
> Use a mask and check the value. Also remove the redundant check inside the
> ixgbe_enter_lplu_t_x550em, because it can only be called when both the mac
> type and revision check pass.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>


