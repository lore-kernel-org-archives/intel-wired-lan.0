From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 18 Feb 2022 05:19:45 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] ice: switch: use a
 struct to pass packet template params
In-Reply-To: <20220127154009.623304-4-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
 <20220127154009.623304-4-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB45544D0038C2B56448258AB79C379@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] ice: switch: use a struct to
>pass packet template params
>
>ice_find_dummy_packet() contains a lot of boilerplate code and a nice room
>for copy-paste mistakes.
>Instead of passing 3 separate pointers back and forth to get packet template
>(dummy) params, directly return a structure containing them. Then, use a
>macro to compose compound literals and avoid code duplication on return
>path.
>Now, dummy packet type/name is needed only once to return a full correct
>triple pkt-pkt_len-offsets, and those are all one-liners.
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 173 +++++++-------------
> 1 file changed, 62 insertions(+), 111 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
