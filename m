From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 17 Jan 2018 15:06:12 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <rcochran@linutronix.de>

This patch introduces SO_TXTIME.  User space enables this option in
order to pass a desired future transmit time in a CMSG when calling
sendmsg(2).

A new field is added to struct sockcm_cookie, and the tstamp from
skbuffs will be used later on.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 arch/alpha/include/uapi/asm/socket.h   |  3 +++
 arch/frv/include/uapi/asm/socket.h     |  3 +++
 arch/ia64/include/uapi/asm/socket.h    |  3 +++
 arch/m32r/include/uapi/asm/socket.h    |  3 +++
 arch/mips/include/uapi/asm/socket.h    |  3 +++
 arch/mn10300/include/uapi/asm/socket.h |  3 +++
 arch/parisc/include/uapi/asm/socket.h  |  3 +++
 arch/s390/include/uapi/asm/socket.h    |  3 +++
 arch/sparc/include/uapi/asm/socket.h   |  3 +++
 arch/xtensa/include/uapi/asm/socket.h  |  3 +++
 include/net/sock.h                     |  2 ++
 include/uapi/asm-generic/socket.h      |  3 +++
 net/core/sock.c                        | 16 ++++++++++++++++
 13 files changed, 51 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index be14f16149d5..065fb372e355 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -112,4 +112,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/frv/include/uapi/asm/socket.h b/arch/frv/include/uapi/asm/socket.h
index 9168e78fa32a..0e95f45cd058 100644
--- a/arch/frv/include/uapi/asm/socket.h
+++ b/arch/frv/include/uapi/asm/socket.h
@@ -105,5 +105,8 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _ASM_SOCKET_H */
 
diff --git a/arch/ia64/include/uapi/asm/socket.h b/arch/ia64/include/uapi/asm/socket.h
index 3efba40adc54..c872c4e6bafb 100644
--- a/arch/ia64/include/uapi/asm/socket.h
+++ b/arch/ia64/include/uapi/asm/socket.h
@@ -114,4 +114,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _ASM_IA64_SOCKET_H */
diff --git a/arch/m32r/include/uapi/asm/socket.h b/arch/m32r/include/uapi/asm/socket.h
index cf5018e82c3d..65276c95b8df 100644
--- a/arch/m32r/include/uapi/asm/socket.h
+++ b/arch/m32r/include/uapi/asm/socket.h
@@ -105,4 +105,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _ASM_M32R_SOCKET_H */
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 49c3d4795963..71370fb3ceef 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -123,4 +123,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/mn10300/include/uapi/asm/socket.h b/arch/mn10300/include/uapi/asm/socket.h
index b35eee132142..d029a40b1b55 100644
--- a/arch/mn10300/include/uapi/asm/socket.h
+++ b/arch/mn10300/include/uapi/asm/socket.h
@@ -105,4 +105,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 1d0fdc3b5d22..061b9cf2a779 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -104,4 +104,7 @@
 
 #define SO_ZEROCOPY		0x4035
 
+#define SO_TXTIME		0x4036
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/s390/include/uapi/asm/socket.h b/arch/s390/include/uapi/asm/socket.h
index 3510c0fd06f4..39d901476ee5 100644
--- a/arch/s390/include/uapi/asm/socket.h
+++ b/arch/s390/include/uapi/asm/socket.h
@@ -111,4 +111,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index d58520c2e6ff..7ea35e5601b6 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -101,6 +101,9 @@
 
 #define SO_ZEROCOPY		0x003e
 
+#define SO_TXTIME		0x003f
+#define SCM_TXTIME		SO_TXTIME
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x5001
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
diff --git a/arch/xtensa/include/uapi/asm/socket.h b/arch/xtensa/include/uapi/asm/socket.h
index 75a07b8119a9..1de07a7f7680 100644
--- a/arch/xtensa/include/uapi/asm/socket.h
+++ b/arch/xtensa/include/uapi/asm/socket.h
@@ -116,4 +116,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif	/* _XTENSA_SOCKET_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 73b7830b0bb8..927af34f3e2c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -777,6 +777,7 @@ enum sock_flags {
 	SOCK_FILTER_LOCKED, /* Filter cannot be changed anymore */
 	SOCK_SELECT_ERR_QUEUE, /* Wake select on error queue */
 	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
+	SOCK_TXTIME,
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -1567,6 +1568,7 @@ void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
 
 struct sockcm_cookie {
+	ktime_t transmit_time;
 	u32 mark;
 	u16 tsflags;
 };
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 0ae758c90e54..a12692e5f7a8 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -107,4 +107,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_TXTIME		61
+#define SCM_TXTIME		SO_TXTIME
+
 #endif /* __ASM_GENERIC_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index abf4cbff99b2..37ef4b33fd92 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1061,6 +1061,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			sock_valbool_flag(sk, SOCK_ZEROCOPY, valbool);
 		break;
 
+	case SO_TXTIME:
+		if (ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+			sock_valbool_flag(sk, SOCK_TXTIME, valbool);
+		else
+			ret = -EPERM;
+		break;
+
 	default:
 		ret = -ENOPROTOOPT;
 		break;
@@ -2130,6 +2137,15 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
 		sockc->tsflags |= tsflags;
 		break;
+	case SO_TXTIME:
+		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+		if (!sock_flag(sk, SOCK_TXTIME))
+			return -EINVAL;
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(ktime_t)))
+			return -EINVAL;
+		sockc->transmit_time = *(ktime_t *)CMSG_DATA(cmsg);
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
-- 
2.15.1

