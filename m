From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 22:01:11 +0000
Subject: [Intel-wired-lan] [PATCH S19 12/15] ice: Reorganize ice_vf
 struct
In-Reply-To: <20190416172439.27908-13-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D399A1D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 12/15] ice: Reorganize ice_vf struct
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The ice_vf struct can be used hundreds of times in our driver so it pays to use
> less memory per struct.
> 
> ice_vf prior to this commit:
>   /* size: 112, cachelines: 2, members: 25 */
>   /* sum members: 101, holes: 4, sum holes: 8 */
>   /* bit holes: 2, sum bit holes: 11 bits */
>   /* padding: 3 */
>   /* last cacheline: 48 bytes */
> 
> ice_vf after this commit:
>   /* size: 104, cachelines: 2, members: 25 */
>   /* sum members: 100, holes: 3, sum holes: 4 */
>   /* bit holes: 1, sum bit holes: 3 bits */
>   /* last cacheline: 40 bytes */
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


