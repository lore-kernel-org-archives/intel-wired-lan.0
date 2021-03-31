From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 20:48:39 +0000
Subject: [Intel-wired-lan] [PATCH S57 02/14] ice: Modify recursive way
 of adding nodes
In-Reply-To: <20210325223517.17722-2-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51055A420766E9B394630AD7FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 02/14] ice: Modify recursive way of
> adding nodes
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> Remove the recursive way of adding the nodes to the layer in order to
> reduce the stack usage. Instead the algorithm is modified to use a while loop.
> 
> The previous code was scanning recursively the nodes horizontally.
> The total stack consumption will be based on number of nodes present on
> that layer. In some cases it can consume more stack.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 130 ++++++++++++---------
>  1 file changed, 77 insertions(+), 53 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


