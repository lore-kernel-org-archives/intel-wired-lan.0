From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 22 Mar 2017 16:15:11 +0000
Subject: [Intel-wired-lan] [next PATCH S63 3/6] i40e/i40evf: Pull out
 code	for cleaning up Rx buffers
In-Reply-To: <1489511727-10959-3-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040697D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, March 14, 2017 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S63 3/6] i40e/i40evf: Pull out code for
> cleaning up Rx buffers
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch pulls out the code responsible for handling buffer recycling and
> page counting and distributes it through several functions.  This allows us to
> commonize the bits that handle either freeing or recycling the buffers.
> 
> As far as the page count tracking one change to the logic is that pagecnt_bias
> is decremented as soon as we call i40e_get_rx_buffer.  It is then the
> responsibility of the function that pulls the data to either increment the
> pagecnt_bias if the buffer can be recycled as-is, or to update page_offset so
> that we are pointing at the correct location for placement of the next buffer.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ibac576360cb7f0b1627f2a993d13c1a8a2bf60af
> ---
> Testing Hints:
>         The greatest risk with this patch is a memory leak of some sort.
>         I already caught one spot where I hadn't fully thought things out
>         in regards to the path where we don't support bulk page updates.
>         My advice would be to test on a RHEL 6.X kernel as well as a RHEL
>         7.X kernel as the 6.X won't support bulk page count updates while
>         the 7.3 and later kernels do.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 73 +++++++++++++++++-----
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 72 ++++++++++++++++------
> ----
>  2 files changed, 89 insertions(+), 56 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


