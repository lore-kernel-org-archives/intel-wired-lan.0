From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Mon, 18 Jan 2021 19:34:52 +0000
Subject: [Intel-wired-lan] [PATCH net v4 0/2] i40e: Fix for link-flapping
Message-ID: <20210118193454.275037-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

VF queues were not brought up when PF was brought up after being downed
if the VF driver disabled VFs queues during PF down. This could happen
in some older or external VF driver implementations.
The problem was that PF driver used vf->queues_enabled as a condition
to decide what link-state it would send out which caused the issue.
Remove the check for vf->queues_enabled in the VF link notify. Now VF
will always be notified of the current link status. Also remove
the queues_enabled member from i40e_vf structure as it is not used
anymore. Also refactor repeated link state reporting code into a
separate helper function i40e_set_vf_link_state().
Otherwise VNF implementation was broken and caused a link flap.

Fixes: 2ad1274fa35a ("i40e: don't report link up for a VF who hasn't enabled")

v2: improve commit message
v3: net tree target
v4: split into 2 patches

Arkadiusz Kubalewski (2):
  i40e: Revert "i40e: don't report link up for a VF who hasn't enabled
    queues"
  i40e: refactor repeated link state reporting code

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 115 ++++++++++--------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   1 -
 2 files changed, 67 insertions(+), 49 deletions(-)


base-commit: 82edab16ec1fc048ef6a9a96ec5a0d1374f5bf3b
-- 
2.18.4

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

