From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:40:19 +0000
Subject: [Intel-wired-lan] [next PATCH S13 03/15] i40e/i40evf: add
	wait	states to NVM state machine
In-Reply-To: <1440798961-17326-4-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E7D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 03/15] i40e/i40evf: add wait states
> to NVM state machine
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> This adds wait states to the NVM update state machine to signify when
> waiting for an update operation to finish, whether we're in the middle of a
> set of Write operations, or we're now idle but waiting.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Iabe91d6579ef6a2ea560647e374035656211ab43
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 13 ++++++++
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 48
> ++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  4 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  4 ++-
>  4 files changed, 55 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
