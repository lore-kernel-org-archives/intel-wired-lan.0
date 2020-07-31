From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:57:01 +0000
Subject: [Intel-wired-lan] [PATCH S51 12/13] ice: adjust profile id map
 locks
In-Reply-To: <20200730001922.52568-12-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-12-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214537464B83A777907241758C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S51 12/13] ice: adjust profile id map locks
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> The profile id map lock should be held till the caller completes all references
> of that profile entries.
> 
> The current code releases the lock right after the match search.
> This caused a driver issue when the profile map entries were referenced
> after it was freed in other thread after the lock was released earlier.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 90 +++++++++----------
>  1 file changed, 45 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


