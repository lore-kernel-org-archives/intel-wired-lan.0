From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:13 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 01/18] sock: Fix SO_ZEROCOPY
 switch case
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-2-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the SO_ZEROCOPY switch case on sock_setsockopt() avoiding the
ret values to be overwritten by the one set on the default case.

Fixes: 28190752c7092 ("sock: permit SO_ZEROCOPY on PF_RDS socket")
Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/core/sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 507d8c6c4319..27f218bba43f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1062,8 +1062,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 				ret = -EINVAL;
 			else
 				sock_valbool_flag(sk, SOCK_ZEROCOPY, valbool);
-			break;
 		}
+		break;
+
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.16.2

