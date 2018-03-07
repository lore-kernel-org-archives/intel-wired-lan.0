From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:20 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend SO_TXTIME APIs with new per-packet parameters: a clockid_t and
a drop_if_late flag. With this commit the API becomes:

- use SO_TXTIME to enable the feature on a socket;
- pass the per-packet arguments through the cmsg header using:
  * SCM_CLOCKID for the clockid to be used as the txtime clock source;
  * SCM_TXTIME for the txtime timestamp;
  * SCM_DROP_IF_LATE for the drop flag. This flag will be used by the
    traffic control to decide if a delayed packet should be dropped.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 arch/alpha/include/uapi/asm/socket.h   |  2 ++
 arch/frv/include/uapi/asm/socket.h     |  2 ++
 arch/ia64/include/uapi/asm/socket.h    |  2 ++
 arch/m32r/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h    |  2 ++
 arch/mn10300/include/uapi/asm/socket.h |  2 ++
 arch/parisc/include/uapi/asm/socket.h  |  2 ++
 arch/s390/include/uapi/asm/socket.h    |  2 ++
 arch/sparc/include/uapi/asm/socket.h   |  2 ++
 arch/xtensa/include/uapi/asm/socket.h  |  2 ++
 include/linux/skbuff.h                 |  3 +++
 include/net/sock.h                     |  2 ++
 include/uapi/asm-generic/socket.h      |  2 ++
 net/core/sock.c                        | 22 +++++++++++++++++++++-
 14 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 065fb372e355..3399dfefa579 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -114,5 +114,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/frv/include/uapi/asm/socket.h b/arch/frv/include/uapi/asm/socket.h
index 0e95f45cd058..43b636836722 100644
--- a/arch/frv/include/uapi/asm/socket.h
+++ b/arch/frv/include/uapi/asm/socket.h
@@ -107,6 +107,8 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _ASM_SOCKET_H */
 
diff --git a/arch/ia64/include/uapi/asm/socket.h b/arch/ia64/include/uapi/asm/socket.h
index c872c4e6bafb..1f06d07aadbe 100644
--- a/arch/ia64/include/uapi/asm/socket.h
+++ b/arch/ia64/include/uapi/asm/socket.h
@@ -116,5 +116,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _ASM_IA64_SOCKET_H */
diff --git a/arch/m32r/include/uapi/asm/socket.h b/arch/m32r/include/uapi/asm/socket.h
index 65276c95b8df..69ab380d8d48 100644
--- a/arch/m32r/include/uapi/asm/socket.h
+++ b/arch/m32r/include/uapi/asm/socket.h
@@ -107,5 +107,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _ASM_M32R_SOCKET_H */
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 71370fb3ceef..97da79f58538 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -125,5 +125,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/mn10300/include/uapi/asm/socket.h b/arch/mn10300/include/uapi/asm/socket.h
index d029a40b1b55..7c7a174fdfae 100644
--- a/arch/mn10300/include/uapi/asm/socket.h
+++ b/arch/mn10300/include/uapi/asm/socket.h
@@ -107,5 +107,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 061b9cf2a779..7fe86b5cd593 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -106,5 +106,7 @@
 
 #define SO_TXTIME		0x4036
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	0x4037
+#define SCM_CLOCKID		0x4038
 
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/s390/include/uapi/asm/socket.h b/arch/s390/include/uapi/asm/socket.h
index 39d901476ee5..97f90c4a9b8c 100644
--- a/arch/s390/include/uapi/asm/socket.h
+++ b/arch/s390/include/uapi/asm/socket.h
@@ -113,5 +113,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 7ea35e5601b6..6397c366dd2d 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -103,6 +103,8 @@
 
 #define SO_TXTIME		0x003f
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	0x0040
+#define SCM_CLOCKID		0x0041
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x5001
diff --git a/arch/xtensa/include/uapi/asm/socket.h b/arch/xtensa/include/uapi/asm/socket.h
index 1de07a7f7680..bc81b02a1f5f 100644
--- a/arch/xtensa/include/uapi/asm/socket.h
+++ b/arch/xtensa/include/uapi/asm/socket.h
@@ -118,5 +118,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif	/* _XTENSA_SOCKET_H */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d8340e6e8814..951969ceaf65 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -788,6 +788,9 @@ struct sk_buff {
 	__u8			tc_redirected:1;
 	__u8			tc_from_ingress:1;
 #endif
+	__u8			tc_drop_if_late:1;
+
+	clockid_t		txtime_clockid;
 
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
diff --git a/include/net/sock.h b/include/net/sock.h
index 16a90a69c9b3..50e36e0f62f6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1571,7 +1571,9 @@ void sk_send_sigurg(struct sock *sk);
 struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
+	clockid_t clockid;
 	u16 tsflags;
+	u8 drop_if_late;
 };
 
 int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index a12692e5f7a8..c9e1ea0097e1 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -109,5 +109,7 @@
 
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
+#define SCM_DROP_IF_LATE	62
+#define SCM_CLOCKID		63
 
 #endif /* __ASM_GENERIC_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 2ba09f311e71..51cfade342ec 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2126,6 +2126,7 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc)
 {
 	u32 tsflags;
+	u8 drop;
 
 	switch (cmsg->cmsg_type) {
 	case SO_MARK:
@@ -2146,13 +2147,32 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
 		sockc->tsflags |= tsflags;
 		break;
-	case SO_TXTIME:
+	case SCM_TXTIME:
 		if (!sock_flag(sk, SOCK_TXTIME))
 			return -EINVAL;
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
 		break;
+	case SCM_DROP_IF_LATE:
+		if (!sock_flag(sk, SOCK_TXTIME))
+			return -EINVAL;
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u8)))
+			return -EINVAL;
+
+		drop = get_unaligned((u8 *)CMSG_DATA(cmsg));
+		if (drop < 0 || drop > 1)
+			return -EINVAL;
+
+		sockc->drop_if_late = drop;
+		break;
+	case SCM_CLOCKID:
+		if (!sock_flag(sk, SOCK_TXTIME))
+			return -EINVAL;
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(clockid_t)))
+			return -EINVAL;
+		sockc->clockid = get_unaligned((clockid_t *)CMSG_DATA(cmsg));
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
-- 
2.16.2

