From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 21 Mar 2022 11:59:49 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 0/5] ice: switch: debloat
 packet templates code
Message-ID: <20220321105954.843154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This hunts down several places around packet templates/dummies for
switch rules which are either repetitive, fragile or just not
really readable code.
It's a common need to add new packet templates and to review such
changes as well, try to simplify both with the help of a pair
macros and aliases.
ice_find_dummy_packet() became very complex at this point with tons
of nested if-elses. It clearly showed this approach does not scale,
so convert its logics to the simple mask-match + static const array.

bloat-o-meter is happy about that (built w/ LLVM 13):

add/remove: 0/1 grow/shrink: 1/1 up/down: 2/-1058 (-1056)
Function                                     old     new   delta
ice_fill_adv_dummy_packet                    289     291      +2
ice_adv_add_update_vsi_list                  201       -    -201
ice_add_adv_rule                            2950    2093    -857
Total: Before=414512, After=413456, chg -0.25%
add/remove: 53/52 grow/shrink: 0/0 up/down: 4660/-3988 (672)
RO Data                                      old     new   delta
ice_dummy_pkt_profiles                         -     672    +672
Total: Before=37895, After=38567, chg +1.77%

Diffstat also looks nice, and adding new packet templates now takes
less lines.

We'll probably come out with dynamic template crafting in a while,
but for now let's improve what we have currently.

From v3[0]:
 - change u64:48 + u64:16 -> u32 + u16 to fix issues on 32-bit
   platforms (and make object code a bit simpler);
 - mention ice_find_dummy_packet() conversion in the cover letter.

From v2[1]:
 - rebase on top of the GTP changes;
 - new: convert template search code to a rodata array (-1000 bytes
   from .text, -400 bytes from ice.ko);
 - collect Reviewed-by and Tested-by (Marcin, Michal).

From v1[2]:
 - rebase on top of the latest next-queue (to fix #3 not applying);
 - adjust the kdoc accordingly to the function proto changes in #3;
 - no functional changes.

[0] https://lore.kernel.org/netdev/20220318161713.680436-1-alexandr.lobakin at intel.com
[1] https://lore.kernel.org/netdev/20220127154009.623304-1-alexandr.lobakin at intel.com
[2] https://lore.kernel.org/netdev/20220124173116.739083-1-alexandr.lobakin at intel.com

Alexander Lobakin (5):
  ice: switch: add and use u16[] aliases to ice_adv_lkup_elem::{h,m}_u
  ice: switch: unobscurify bitops loop in ice_fill_adv_dummy_packet()
  ice: switch: use a struct to pass packet template params
  ice: switch: use convenience macros to declare dummy pkt templates
  ice: switch: convert packet template match code to rodata

 drivers/net/ethernet/intel/ice/ice_switch.c | 489 ++++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h |  12 +-
 2 files changed, 211 insertions(+), 290 deletions(-)

-- 
2.35.1

