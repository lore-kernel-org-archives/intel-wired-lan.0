From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 24 Jan 2022 18:31:11 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/4] ice: switch: debloat packet
 templates code
Message-ID: <20220124173116.739083-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Applies on top of
commit 1ed7aede32fd ("ice: Add support for inner etype in switchdev")
(here: [0]) to exclude non-trivial conflicts and cover the code added
there as well.

This hunts down several places around packet templates/dummies for
switch rules which are either repetitive, fragile or just not
really readable code.
It's a common need to add new packet templates and to review such
changes as well, try to simplify both with the help of a pair
macros and aliases.

bloat-o-meter is happy about that (built w/ LLVM 13):

add/remove: 0/1 grow/shrink: 2/0 up/down: 148/-202 (-54)
Function                                     old     new   delta
ice_add_adv_rule                            2383    2529    +146
ice_fill_adv_dummy_packet                    289     291      +2
ice_adv_add_update_vsi_list                  202       -    -202
Total: Before=395813, After=395759, chg -0.01%

Diffstat also looks nice, and adding new packet templates now takes
less lines.

We'll probably come out with dynamic template crafting in a while,
but for now let's improve what we have currently.

[0] https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20220110/027399.html

Alexander Lobakin (4):
  ice: switch: add and use u16[] aliases to ice_adv_lkup_elem::{h,m}_u
  ice: switch: unobscurify bitops loop in ice_fill_adv_dummy_packet()
  ice: switch: use a struct to pass packet template params
  ice: switch: use convenience macros to declare dummy pkt templates

 drivers/net/ethernet/intel/ice/ice_switch.c | 264 ++++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h |  12 +-
 2 files changed, 120 insertions(+), 156 deletions(-)

base-commit: 1ed7aede32fd46f0fac72cef138c9d5e36326c98
-- 
2.34.1

