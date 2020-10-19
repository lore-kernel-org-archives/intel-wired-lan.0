From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Mon, 19 Oct 2020 23:50:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/3] i40e: Add software
 controlled DCB feature
Message-ID: <20201019235029.176050-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

DCB feature was supported by Firmware LLDP agent only.
If Firmware LLDP agent is enabled it receives DCB related TLVs,
then it configures hardware accordingly.

Allow the OS to take control of handling LLDP frames related
to DCB functionality.

After disabling the Firmware LLDP agent (private flag:
disable-fw-lldp : on), the driver configures DCB with default
values (only one Traffic Class). At the same time, it
allows the OS (software based LLDP agent - userspace application
i.e. lldpad) to receive DCB TLVs and set desired DCB config
through DCB related netlink callbacks.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Arkadiusz Kubalewski (3):
  i40e: Add hardware configuration for software based DCB
  i40e: Add init and default config of software based DCB
  i40e: Add netlink callbacks support for software based DCB feature

 drivers/net/ethernet/intel/i40e/i40e.h        |  15 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |  65 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 949 +++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h    | 169 +++-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c | 752 +++++++++++++-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 528 +++++++++-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   9 +-
 .../net/ethernet/intel/i40e/i40e_register.h   | 172 +++-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   3 +-
 11 files changed, 2614 insertions(+), 79 deletions(-)


base-commit: 977a109bc3e30ee6303dd767090e04eb5170e986
-- 
2.18.4

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

