From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Dec 2016 22:41:43 +0000
Subject: [Intel-wired-lan] [next PATCH S56 3/8] i40e: Save link FEC
	info	from link up event
In-Reply-To: <1480710782-9195-4-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39242@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S56 3/8] i40e: Save link FEC info from
> link up event
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Store the FEC status bits from the link up event into the hw_link_info
> structure.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I9a7b256f6dfb0dce89c2f503075d0d383526832e
> ---
> Testing Hints: In support of DCR 2228, this commit stores the FEC data for
> later display in the "link up" kernel log message.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 21 +++++++++++++++++++-
> -
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 +
>  4 files changed, 23 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


