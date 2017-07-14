From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Jul 2017 22:35:55 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 08/11] i40evf: fix
 possible	snprintf truncation of q_vector->name
In-Reply-To: <20170712094614.76501-8-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1C40@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S75-V3 08/11] i40evf: fix possible
> snprintf truncation of q_vector->name
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The q_vector names are based on the interface name with a driver prefix,
> the type of q_vector setup, and the queue number. We previously set the
> size of this variable to IFNAMSIZ + 9, which is incorrect, because we actually
> include a minimum of 14 characters extra beyond the interface name size.
> 
> New versions of GCC since 7 include a new warning that detects this possible
> truncation and complains. We can fix this by increasing the size incase our
> interface name is too large to avoid truncation. We don't need to go beyond
> 14 because the compiler is smart enough to realize our values can never
> exceed size of 1. We do go up to 15 here because possible future changes
> may increase the number of queues beyond one digit.
> 
> While we are here, also change some variables to be unsigned (since they
> are never negative) and stop using an extra unnecessary %s format specifier.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 21 +++++++++------------
>  2 files changed, 10 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


