From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Fri, 26 Jul 2019 06:41:02 +0000
Subject: [Intel-wired-lan] [next PATCH S8 09/12] i40e: make
 i40e_set_mac_type() public
In-Reply-To: <20190723100144.57435-9-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-9-alice.michael@intel.com>
Message-ID: <D4D6338F2E4CB34CB91C5312C72AAC810D6E86@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Tuesday, July 23, 2019 12:02 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Subject: [next PATCH S8 09/12] i40e: make i40e_set_mac_type() public

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Make i40e_set_mac_type() public. i40e driver requires i40e_set_mac_type() to be public. It is required for recovery mode handling. Without this patch recovery mode could not be detected in i40e_probe().

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 7af1b7477140..de996a80013e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -13,7 +13,7 @@
  * This function sets the mac type of the adapter based on the
  * vendor ID and device ID stored in the hw structure.
  **/
-static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
+i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 {
 	i40e_status status = 0;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index eac88bcc6c06..9c810d54df1c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -326,6 +326,8 @@ void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,  void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw);  void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status);
 
+i40e_status i40e_set_mac_type(struct i40e_hw *hw);
+
 extern struct i40e_rx_ptype_decoded i40e_ptype_lookup[];
 
 static inline struct i40e_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
--
2.21.0

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

