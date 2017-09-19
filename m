From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Sep 2017 19:20:12 +0000
Subject: [Intel-wired-lan] [net PATCH] ixgbe: incorrect xdp ring
 accounting in ethtool tx_frame param
In-Reply-To: <20170907173248.7589.44547.stgit@john-Precision-Tower-5810>
References: <20170907173248.7589.44547.stgit@john-Precision-Tower-5810>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA911@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of John Fastabend
> Sent: Thursday, September 7, 2017 10:33 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] ixgbe: incorrect xdp ring accounting in
> ethtool tx_frame param
> 
> Changing the TX ring parameters with an XDP program attached may cause
> the XDP queues to be cleared and the TX rings to be incorrectly configured.
> 
> Fix by doing correct ring accounting in setup call.
> 
> Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


