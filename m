From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 22 Mar 2017 16:15:36 +0000
Subject: [Intel-wired-lan] [next PATCH S63 4/6] i40e/i40evf:
	Break	i40e_fetch_rx_buffer up to allow for reuse of frag code
In-Reply-To: <1489511727-10959-4-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040698C@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S63 4/6] i40e/i40evf: Break
> i40e_fetch_rx_buffer up to allow for reuse of frag code
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to clean up the code in preparation for us adding support
> for build_skb.  Specifically we deconstruct i40e_fetch_buffer into several
> functions so that those functions can later be reused when we add a path for
> build_skb.
> 
> Specifically with this change we split out the code for adding a page to an
> exiting skb.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Iab1efbab6b8b97cb60ab9fdd0be1d37a056a154d
> ---
> Testing Hints:
>         The greatest risk with this patch is a memory leak of some sort.
>         I already caught one spot where I hadn't fully thought things out
>         in regards to the path where we don't support bulk page updates.
>         My advice would be to test on a RHEL 6.X kernel as well as a RHEL
>         7.X kernel as the 6.X won't support bulk page count updates while
>         the 7.3 and later kernels do.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 138 ++++++++++++------------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 138 ++++++++++++-----------
> ---
>  2 files changed, 130 insertions(+), 146 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

