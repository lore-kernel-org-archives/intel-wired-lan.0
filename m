From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 21:49:42 +0000
Subject: [Intel-wired-lan] [next PATCH S55 13/14] i40e: update
	comment	explaining where FDIR buffers are freed
In-Reply-To: <1480377971-23412-14-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-14-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39002@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S55 13/14] i40e: update comment
> explaining where FDIR buffers are freed
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The original comment implies that the only location where the raw_packet
> buffer will be freed is in i40e_clean_tx_ring() which is incorrect. In fact this
> isn't even the normal case. Update the comment explaining where the
> memory is freed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ie0defc35ed1c3af183f81fdc60b6d783707a5595
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


