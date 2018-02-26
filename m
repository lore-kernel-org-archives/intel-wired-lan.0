From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Feb 2018 23:13:47 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 2/3] ixgbe: fix ipsec
 trailer length
In-Reply-To: <1519326597-7679-3-git-send-email-shannon.nelson@oracle.com>
References: <1519326597-7679-1-git-send-email-shannon.nelson@oracle.com>
 <1519326597-7679-3-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94AC3C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Thursday, February 22, 2018 11:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH next-queue 2/3] ixgbe: fix ipsec trailer
> length
> 
> Fix up the Tx trailer length calculation.  We can't believe the trailer len from
> the xstate information because it was calculated before the packet was put
> together and padding added.  This bit of code finds the padding value in the
> trailer, adds it to the authentication length, and saves it so later we can put it
> into the Tx descriptor to tell the device where to stop the checksum
> calculation.
> 
> Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 24
> +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


