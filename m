From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 21:50:58 +0000
Subject: [Intel-wired-lan] [next PATCH S55 10/14] i40e/i40evf: Limit
	dma	sync of RX buffers to actual packet size
In-Reply-To: <1480377971-23412-11-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39024@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S55 10/14] i40e/i40evf: Limit dma sync
> of RX buffers to actual packet size
> 
> From: "Scott Peterson" <scott.d.peterson@intel.com>
> 
> On packet RX, we perform a dma sync for cpu before passing the packet up.
> Here we limit that sync to the actual length of the incoming packet, rather
> than always syncing the entire buffer.
> 
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> Change-ID: I626aaf6c37275a8ce9e81efcaa773f327b331487
> ---
> Testing Hints:
> Verify traffic is still passed correctly with the same or better performance as
> before this patch
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 16 +++++++++-------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 16 +++++++++-------
>  2 files changed, 18 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


