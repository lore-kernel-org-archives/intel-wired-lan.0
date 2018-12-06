From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Dec 2018 22:48:18 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix race when the VF driver
 does a reset
In-Reply-To: <20181205135426.26431-1-ross.lagerwall@citrix.com>
References: <20181205135426.26431-1-ross.lagerwall@citrix.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32CA0D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ross Lagerwall
> Sent: Wednesday, December 5, 2018 5:54 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: Ross Lagerwall <ross.lagerwall@citrix.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix race when the VF driver does a
> reset
> 
> When the VF driver does a reset, it (at least the Linux one) writes to the
> VFCTRL register to issue a reset and then immediately sends a reset message
> using the mailbox API. This is racy because when the PF driver detects that
> the VFCTRL register reset pin has been asserted, it clears the mailbox
> memory. Depending on ordering, the reset message sent by the VF could be
> cleared by the PF driver. It then responds to the cleared message with a
> NACK which causes the VF driver to malfunction.
> Fix this by deferring clearing the mailbox memory until the reset message is
> received.
> 
> Fixes: 939b701ad633 ("ixgbe: fix driver behaviour after issuing VFLR")
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


