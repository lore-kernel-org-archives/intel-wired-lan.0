From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 16 Dec 2020 15:14:03 +0000
Subject: [Intel-wired-lan] [PATCH net v3 0/2] Multiple Traffic Class support
 for VF-d
Message-ID: <20201216151403.19610-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series focuses on adding flow director for both IPv6 support and
VLAN field.

Patch 1/2 focuses on implementing a flow director support for IPv6 by
adding packet templates, handlers and refactoring the code to make it
more generic.

Patch 2/2 allows user to specify VLAN field and add it to flow
director by showing vlan field in "ethtool -n ethx" command. It also
refactors static static arrays with runtime dummy packet creation.

Przemyslaw Patynowski (2):
  i40e: Add flow director support for IPv6
  i40e: VLAN field for flow director

 drivers/net/ethernet/intel/i40e/i40e.h        |  11 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 239 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  79 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 534 +++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   2 +
 5 files changed, 647 insertions(+), 218 deletions(-)

-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

