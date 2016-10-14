From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 16:41:03 +0000
Subject: [Intel-wired-lan] [next PATCH S50 5/6] i40e: Implementation
	of	ERROR state for NVM update state machine
In-Reply-To: <1476224818-16844-6-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA11410@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sosin, Maciej <maciej.sosin@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S50 5/6] i40e: Implementation of
> ERROR state for NVM update state machine
> 
> From: Maciej Sosin <maciej.sosin@intel.com>
> 
> This patch adds I40E_NVMUPD_STATE_ERROR state for NVM update.
> Without this patch driver has no possibility to return NVM image write
> failure.This state is being set when ARQ rises error.
> arq_last_status is also updated every time when ARQ event comes, not only
> on error cases.
> 
> Signed-off-by: Maciej Sosin <maciej.sosin@intel.com>
> Change-ID: I67ce43ba22a240773c2821b436e96054db0b7c81
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c      | 16 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h     |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c |  4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   |  1 +
>  5 files changed, 22 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


