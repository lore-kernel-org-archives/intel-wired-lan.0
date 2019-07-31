From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:11:57 +0000
Subject: [Intel-wired-lan] [PATCH S25 05/12] ice: added sibling head to
 parse nodes
In-Reply-To: <20190725095401.24590-5-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA9B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 05/12] ice: added sibling head to parse
> nodes
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> There was a bug in the previous code which never traverses all the children
> to get the first node of the requested layer. Add a sibling head pointer to
> point the first node of each layer per TC. This helps traverse easier and
> quicker and also removes the recursion.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 57 ++++++++--------------
> drivers/net/ethernet/intel/ice/ice_type.h  |  2 +
>  2 files changed, 23 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


