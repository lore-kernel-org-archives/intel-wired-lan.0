From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 28 Dec 2020 10:36:33 +0000
Subject: [Intel-wired-lan] [PATCH net v1] virtchnl: Fix layout of RSS
 structures
Message-ID: <20201228103633.11621-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Norbert Ciosek <norbertx.ciosek@intel.com>

Move "key" and "lut" fields at the end of RSS structures.
They are arrays of size 1 used to fill in the data
in dynamically allocated memory located after both structures.
Previous layout could lead to unwanted compiler optimizations
in loops when iterating over these arrays.

Fixes: 65ece6de0114 ("virtchnl: Add missing explicit padding to structures")
Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index ac4a1d3..44945d6 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -529,8 +529,8 @@ struct virtchnl_eth_stats {
 struct virtchnl_rss_key {
 	u16 vsi_id;
 	u16 key_len;
-	u8 key[1];         /* RSS hash key, packed bytes */
 	u8 pad[1];
+	u8 key[1];         /* RSS hash key, packed bytes */
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
@@ -538,8 +538,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
 struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
-	u8 lut[1];        /* RSS lookup table */
 	u8 pad[1];
+	u8 lut[1];        /* RSS lookup table */
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

