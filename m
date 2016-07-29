From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 16:03:31 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 03/12] i40e: reset RX
	csum	error stat with other pf stats
In-Reply-To: <1469646161-30024-4-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB8B9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 03/12] i40e: reset RX csum
> error stat with other pf stats
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> When we are resetting the pf stats we should also reset the RX csum error
> stat.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I7af5ee0ec81a10f6deee1a7b8c2082ea068ef620
> ---
> Testing Hints: Make sure the port.rx_csum_bad stat resets in ethtool after a
> pfr.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Stats properly reset
