From: Jacek Kalwas <jacek.kalwas@intel.com>
Date: Thu, 12 Apr 2018 12:03:13 -0700
Subject: [Intel-wired-lan] [net] udp: enable UDP checksum offload for ESP
Message-ID: <20180412190315.3102-1-jacek.kalwas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In case NIC has support for ESP TX CSUM offload skb->ip_summed is not
set to CHECKSUM_PARTIAL which results in checksum calculated by SW.

Fix enables ESP TX CSUM for UDP by extending condition with check for
NETIF_F_HW_ESP_TX_CSUM.

Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4c11b810a447..a2dfb5a9ba76 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -907,7 +907,7 @@ static int __ip_append_data(struct sock *sk,
 	    length + fragheaderlen <= mtu &&
 	    rt->dst.dev->features & (NETIF_F_HW_CSUM | NETIF_F_IP_CSUM) &&
 	    !(flags & MSG_MORE) &&
-	    !exthdrlen)
+	    (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSUM)))
 		csummode = CHECKSUM_PARTIAL;
 
 	cork->length += length;
-- 
2.14.3

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

