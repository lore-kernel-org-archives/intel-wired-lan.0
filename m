From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 22:00:13 +0000
Subject: [Intel-wired-lan] [PATCH S19 10/15] ice: Reorganize tx_buf and
 ring structs
In-Reply-To: <20190416172439.27908-11-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3999FB@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S19 10/15] ice: Reorganize tx_buf and ring
> structs
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Use more efficient structure ordering by using the pahole tool and a lot of
> code inspection to get hot cache lines to have packed data (no holes if
> possible) and adjacent warm data.
> 
> ice_ring prior to this change:
>   /* size: 192, cachelines: 3, members: 23 */
>   /* sum members: 158, holes: 4, sum holes: 12 */
>   /* padding: 22 */
> 
> ice_ring after this change:
>   /* size: 192, cachelines: 3, members: 25 */
>   /* sum members: 162, holes: 1, sum holes: 1 */
>   /* padding: 29 */
> 
> ice_tx_buf prior to this change:
>   /* size: 48, cachelines: 1, members: 7 */
>   /* sum members: 38, holes: 2, sum holes: 6 */
>   /* padding: 4 */
>   /* last cacheline: 48 bytes */
> 
> ice_tx_buf after this change:
>   /* size: 40, cachelines: 1, members: 7 */
>   /* sum members: 38, holes: 1, sum holes: 2 */
>   /* last cacheline: 40 bytes */
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.h | 35 ++++++++++++++---------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


