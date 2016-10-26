From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:23:18 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 7/8] i40e: fix trivial
 typo in	naming of i40e_sync_filters_subtask
In-Reply-To: <1477436933-13679-8-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA292D3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S51-V2 7/8] i40e: fix trivial typo in
> naming of i40e_sync_filters_subtask
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A comment incorrectly referred to i40e_vsi_sync_filters_subtask which does
> not actually exist. Reference the correct function instead.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I6bd805c605741ffb6fe34377259bb0d597edfafd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


