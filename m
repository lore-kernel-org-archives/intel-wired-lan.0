From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Fri, 14 Jan 2022 13:19:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 0/4] Eliminate race condition
 occurrence during sending ASQ commands
Message-ID: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Provide modifications in ASQ commands in order to
prevent for race condition occurrences.
Add new versions of ASQ commands based on sending commands
in atomic context. New versions of commands are marked as _v2.
Also change already existing ASQ commands to be able to work
in atomic context. Make them to invoking previously added
i40e_asq_send_command_atomic() function to perform aq calls.

Eliminate problem with race conditions connected to accessing
hw->aq.asq_last_status during callig ASQ commands.

1. Change several i40e_aq_ functions to send commands in atomic
context by using i40e_asq_send_command_atomic(..., true).

2. Add new versions of send ASQ command functions including
new version of i40e_aq_remove_macvlan().

3. Add new version of i40e_aq_add_macvlan() function.

4. Change i40e_aqc_add_filters() and i40e_aqc_del_filters() functions
located in i40e_main.c to use new versions of i40e_aq_add_macvlan()
and i40e_aq_remove_macvlan().

Jedrzej Jagielski (4):
  i40e: Add sending commands in atomic context
  i40e: Add new versions of send ASQ command functions
  i40e: Add new version of i40e_aq_add_macvlan function
  i40e: Fix race condition while adding/deleting MAC/VLAN filters

 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  92 ++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 155 +++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  24 +--
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  25 +++
 4 files changed, 250 insertions(+), 46 deletions(-)

---
V2: change order of patches, provide several little changes connected to
variables initialisation and removing unnecessary status variables
---

-- 
2.18.2

