From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:57:44 +0000
Subject: [Intel-wired-lan] [PATCH S51 03/13] ice: Fix RSS profile locks
In-Reply-To: <20200730001922.52568-3-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-3-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145F062A98C69F0FFE4654F8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 03/13] ice: Fix RSS profile locks
> 
> From: Vignesh Sridhar <vignesh.sridhar@intel.com>
> 
> Replacing flow profile locks with RSS profile locks in the function to remove all
> RSS rules for a given VSI. This is to align the locks used for RSS rule addition to
> VSI and removal during VSI teardown to avoid a race condition owing to
> several iterations of the above operations.
> In function to get RSS rules for given VSI and protocol header replacing the
> pointer reference of the RSS entry with a copy of hash value to ensure
> thread safety.
> 
> Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


