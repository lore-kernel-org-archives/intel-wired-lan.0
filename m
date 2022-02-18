From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 18 Feb 2022 05:20:09 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 4/4] ice: switch: use
 convenience macros to declare dummy pkt templates
In-Reply-To: <20220127154009.623304-5-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
 <20220127154009.623304-5-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB4554334A9DC2D9C504A657C79C379@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH v2 net-next 4/4] ice: switch: use convenience
>macros to declare dummy pkt templates
>
>Declarations of dummy/template packet headers and offsets can be minified
>to improve readability and simplify adding new templates.
>Move all the repetitive constructions into two macros and let them do the
>name and type expansions.
>Linewrap removal is yet another positive side effect.
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 83 +++++++++++----------
> 1 file changed, 42 insertions(+), 41 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
