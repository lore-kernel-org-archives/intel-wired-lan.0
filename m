From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Oct 2017 19:04:44 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 3/9] i40evf: use spinlock
 to	protect (mac|vlan)_filter_list
In-Reply-To: <20171027150656.68250-3-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADD34@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 3/9] i40evf: use spinlock to
> protect (mac|vlan)_filter_list
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Stop overloading the __I40EVF_IN_CRITICAL_TASK bit lock to protect the
> mac_filter_list and vlan_filter_list. Instead, implement a spinlock to protect
> these two lists, similar to how we protect the hash in the i40e PF code.
> 
> Ensure that every place where we access the list uses the spinlock to ensure
> consistency, and stop holding the critical section around blocks of code which
> only need access to the macvlan filter lists.
> 
> This refactor helps simplify the locking behavior, and is necessary as a future
> refactor to the __I40EVF_IN_CRITICAL_TASK would cause a deadlock
> otherwise.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 84 +++++++++++--------
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 42 +++++++++--
>  3 files changed, 81 insertions(+), 49 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


