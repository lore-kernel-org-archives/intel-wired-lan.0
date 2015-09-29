From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 29 Sep 2015 12:08:12 -0700
Subject: [Intel-wired-lan] [next PATCH S15 04/15] i40e: Lock for VSI's
	MAC filter list
In-Reply-To: <1441315142-173025-5-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <20150929120812.00006d1c@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 3 Sep 2015 17:18:51 -0400
Catherine Sullivan <catherine.sullivan@intel.com> wrote:

> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch introduces a spinlock which is to be used for synchronizing
> access to VSI's MAC filter list.
> 
> This patch also synchronizes execution of other codepaths which are
> accessing VSI's MAC filter list with execution of
> service_task:sync_vsi_filters.
> 
> In function i40e_add_vsi, copied out LAA MAC address instead of cloning
> MAC filter entry because only MAC address is needed to remove MAC VLAN
> filter from FW/HW.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I0e10ac7c715d44aa994239642aa4d57c998573a2
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 326 +++++++++++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  26 +-
>  4 files changed, 300 insertions(+), 56 deletions(-)
> 

This patch introduces a locking dependency issue, already solved by
another patch we have prepared, which should either be applied on top of
this one or squashed onto it.
