From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 25 Mar 2022 10:26:18 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 5/5] ice: switch: convert
 packet template match code to rodata
In-Reply-To: <20220321105954.843154-6-alexandr.lobakin@intel.com>
References: <20220321105954.843154-1-alexandr.lobakin@intel.com>
 <20220321105954.843154-6-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB45541D2B0B26CD592841A33F9C1A9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH v4 net-next 5/5] ice: switch: convert packet
>template match code to rodata
>
>Trade text size for rodata size and replace tons of nested if-elses to the const
>mask match based structs. The almost entire
>ice_find_dummy_packet() now becomes just one plain while-increment loop.
>The order in ice_dummy_pkt_profiles[] should be same with the if-elses order
>previously, as masks become less and less strict through the array to follow
>the original code flow.
>Apart from removing 80 locs of 4-level if-elses, it brings a solid text size
>optimization:
>
>add/remove: 0/1 grow/shrink: 1/1 up/down: 2/-1058 (-1056)
>Function                                     old     new   delta
>ice_fill_adv_dummy_packet                    289     291      +2
>ice_adv_add_update_vsi_list                  201       -    -201
>ice_add_adv_rule                            2950    2093    -857
>Total: Before=414512, After=413456, chg -0.25%
>add/remove: 53/52 grow/shrink: 0/0 up/down: 4660/-3988 (672)
>RO Data                                      old     new   delta
>ice_dummy_pkt_profiles                         -     672    +672
>Total: Before=37895, After=38567, chg +1.77%
>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 215 ++++++++++----------
> 1 file changed, 108 insertions(+), 107 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
