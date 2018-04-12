From: Jacek Kalwas <jacek.kalwas@intel.com>
Date: Thu, 12 Apr 2018 12:03:15 -0700
Subject: [Intel-wired-lan] [net] xfrm: cover crypto status in xfrm_input
In-Reply-To: <20180412190315.3102-1-jacek.kalwas@intel.com>
References: <20180412190315.3102-1-jacek.kalwas@intel.com>
Message-ID: <20180412190315.3102-3-jacek.kalwas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Status checking in xfrm_input doesn't cover CRYPTO_GENERIC_ERROR and
CRYPTO_INVALID_PACKET_SYNTAX.

Given patch adds additional check for CRYPTO_INVALID_PACKET_SYNTAX and
treats CRYPTO_GENERIC_ERROR as status matching LINUX_MIB_XFRMINERROR.

Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>
---
 net/xfrm/xfrm_input.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 352abca2605f..08d70ea774f9 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -285,7 +285,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					goto drop;
 				}
 
-				XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+				if (xo->status & CRYPTO_INVALID_PACKET_SYNTAX) {
+					XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+					goto drop;
+				}
+
+				XFRM_INC_STATS(net, LINUX_MIB_XFRMINERROR);
 				goto drop;
 			}
 
-- 
2.14.3

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

