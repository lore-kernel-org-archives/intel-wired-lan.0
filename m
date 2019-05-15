From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Wed, 15 May 2019 12:00:28 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 04/11] iavf: Change
 GFP_KERNEL to GFP_ATOMIC in kzalloc()
In-Reply-To: <20190514173709.62431-4-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-4-alice.michael@intel.com>
Message-ID: <0EF347314CF65544BA015993979A29CD631F6C66@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Tuesday, May 14, 2019 7:37 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: [next PATCH S5 iavf 04/11] iavf: Change GFP_KERNEL to GFP_ATOMIC in kzalloc()

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

iavf_add_vlan() is being called in atomic context so kzalloc() needs GFP_ATOMIC. This patch fixes it.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 9ce04a8c0d0f..8a37b9f604e2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -659,7 +659,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter, u16 vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (!f) {
-		f = kzalloc(sizeof(*f), GFP_KERNEL);
+		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
 			goto clearout;
 
--
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

