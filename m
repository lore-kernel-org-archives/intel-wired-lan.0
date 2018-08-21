From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:07:47 +0000
Subject: [Intel-wired-lan] [PATCH v3 09/15] ice: Clean up register file
In-Reply-To: <20180809132958.23036-10-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-10-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195458C0@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 09/15] ice: Clean up register file
> 
> This patch cleans up the existing register definitions.
> 
> 1) Several instances of long defines names used in the BIT() macro
>    were replaced to use the actual values they represent. As a
>    result some defines for shifts (ending with _S) that were used
>    only to create bitmasks were removed completely.
> 
> 2) Apply more consistent tab spacing.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   | 417 ++++++++----------
>  1 file changed, 188 insertions(+), 229 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


