From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 20:09:04 +0000
Subject: [Intel-wired-lan] [PATCH S43 14/15] ice: Fix for memory leaks
 and modify ICE_FREE_CQ_BUFS
In-Reply-To: <20200516003644.4658-14-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-14-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165955CB88E2F3407749A6A88CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 14/15] ice: Fix for memory leaks and
> modify ICE_FREE_CQ_BUFS
> 
> From: Surabhi Boob <surabhi.boob@intel.com>
> 
> Handle memory leaks during control queue initialization and buffer allocation
> failures. The macro ICE_FREE_CQ_BUFS is modified to re-use for this fix.
> 
> Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 49 +++++++++++--------
>  1 file changed, 28 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


