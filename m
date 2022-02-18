From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 18 Feb 2022 05:19:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/4] ice: switch:
 unobscurify bitops loop in ice_fill_adv_dummy_packet()
In-Reply-To: <20220127154009.623304-3-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
 <20220127154009.623304-3-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB45547FA58FB4D79792D6598F9C379@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH v2 net-next 2/4] ice: switch: unobscurify
>bitops loop in ice_fill_adv_dummy_packet()
>
>A loop performing header modification according to the provided mask in
>ice_fill_adv_dummy_packet() is very cryptic (and error-prone).
>Replace two identical cast-deferences with a variable. Replace three struct-
>member-array-accesses with a variable. Invert the condition, reduce the
>indentation by one -> eliminate line wraps.
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
