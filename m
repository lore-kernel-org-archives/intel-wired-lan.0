From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 25 Mar 2022 10:25:42 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 4/5] ice: switch: use
 convenience macros to declare dummy pkt templates
In-Reply-To: <20220321105954.843154-5-alexandr.lobakin@intel.com>
References: <20220321105954.843154-1-alexandr.lobakin@intel.com>
 <20220321105954.843154-5-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB455443055341CB2F91E3E34D9C1A9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Alexander Lobakin
>Sent: Monday, March 21, 2022 4:30 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>;
>netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Jakub Kicinski
><kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
><davem@davemloft.net>
>Subject: [Intel-wired-lan] [PATCH v4 net-next 4/5] ice: switch: use convenience
>macros to declare dummy pkt templates
>
>Declarations of dummy/template packet headers and offsets can be minified
>to improve readability and simplify adding new templates.
>Move all the repetitive constructions into two macros and let them do the
>name and type expansions.
>Linewrap removal is yet another positive side effect.
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 133 +++++++++-----------
> 1 file changed, 62 insertions(+), 71 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
