From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 18 Feb 2022 05:18:46 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/4] ice: switch: add and
 use u16[] aliases to ice_adv_lkup_elem::{h, m}_u
In-Reply-To: <20220127154009.623304-2-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
 <20220127154009.623304-2-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB455479F0312E6C9DD12386659C379@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Alexander Lobakin
>Sent: Thursday, January 27, 2022 9:10 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>;
>netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Jakub Kicinski
><kuba@kernel.org>; David S. Miller <davem@davemloft.net>
>Subject: [Intel-wired-lan] [PATCH v2 net-next 1/4] ice: switch: add and use
>u16[] aliases to ice_adv_lkup_elem::{h, m}_u
>
>ice_adv_lkup_elem fields h_u and m_u are being accessed as raw u16 arrays
>in several places.
>To reduce cast and braces burden, add permanent array-of-u16 aliases with
>the same size as the `union ice_prot_hdr` itself via anonymous unions to the
>actual struct declaration, and just access them directly.
>
>This:
> - removes the need to cast the union to u16[] and then dereference
>   it each time -> reduces the horizon for potential bugs;
> - improves -Warray-bounds coverage -- the array size is now known
>   at compilation time;
> - addresses cppcheck complaints.
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 15 +++++++--------
>drivers/net/ethernet/intel/ice/ice_switch.h | 12 ++++++++++--
> 2 files changed, 17 insertions(+), 10 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
