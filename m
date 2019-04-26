From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:37:55 +0000
Subject: [Intel-wired-lan] [PATCH S18 12/15] ice: Use bitfields where
 possible
In-Reply-To: <20190416172128.27184-13-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39994C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 12/15] ice: Use bitfields where possible
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was converted to not use bool, but it was neglected that the bools
> should have been converted to bitfields as bitfields in software structures
> are ok, as long as they use the correct kinds of unsigned types. This avoids
> wasting lots of storage space to store single bit values.
> 
> One of the change hunks moves a variable lport out of a group of
> "combinable" bitfields because all bits of the u8 lport are valid and the
> variable can be packed in the struct in struct holes.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_type.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


