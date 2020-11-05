From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  5 Nov 2020 11:28:12 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next v2 9/9] samples/bpf: add
 option to set the busy-poll budget
In-Reply-To: <20201105102812.152836-1-bjorn.topel@gmail.com>
References: <20201105102812.152836-1-bjorn.topel@gmail.com>
Message-ID: <20201105102812.152836-10-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Support for the SO_BUSY_POLL_BUDGET setsockopt, via the batching
option ('b').

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 162444fa9627..0ed05e6e40e2 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1482,6 +1482,11 @@ static void apply_setsockopt(struct xsk_socket_info *xsk)
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
+
+	sock_opt = opt_batch_size;
+	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL_BUDGET,
+		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
+		exit_with_error(errno);
 }
 
 int main(int argc, char **argv)
-- 
2.27.0

