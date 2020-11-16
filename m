From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:49 +0100
Subject: [Intel-wired-lan] [PATCH 5/8] libbpf: extend netlink attribute API
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-6-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Extend netlink attribute API to put a different attribute into
the netlink message (nest{start, end}, string, u32, flag, etc).
Add new API to parse attribute array.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 tools/lib/bpf/nlattr.c | 105 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/nlattr.h |  22 +++++++++
 2 files changed, 127 insertions(+)

diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index b607fa9852b1..b37b4d266832 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -83,6 +83,52 @@ static inline int nlmsg_len(const struct nlmsghdr *nlh)
 	return nlh->nlmsg_len - NLMSG_HDRLEN;
 }
 
+/**
+ * Create attribute index table based on a stream of attributes.
+ * @arg tb		Index array to be filled (indexed from 0 to elem-1).
+ * @arg elem		Number of attributes in the table.
+ * @arg maxtype		Maximum attribute type expected and accepted.
+ * @arg head		Head of attribute stream.
+ * @arg policy		Attribute validation policy.
+ *
+ * Iterates over the stream of attributes and stores a pointer to each
+ * attribute in the index array using incremented counter as index to
+ * the array. Attribute with a index greater than or equal to the elem value
+ * specified will be ignored and function terminates with error. If a policy
+ * is not NULL, the attribute will be validated using the specified policy.
+ *
+ * @see nla_validate
+ * @return 0 on success or a negative error code.
+ */
+int libbpf_nla_parse_table(struct nlattr *tb[], int elem, struct nlattr *head,
+			   int maxtype, struct libbpf_nla_policy *policy)
+{
+	struct nlattr *nla;
+	int rem, err = 0;
+	int idx = 0;
+
+	memset(tb, 0, sizeof(struct nlattr *) * elem);
+
+	libbpf_nla_for_each_attr(nla, libbpf_nla_data(head), libbpf_nla_len(head), rem) {
+		if (idx >= elem) {
+			err = -EMSGSIZE;
+			goto errout;
+		}
+
+		if (policy) {
+			err = validate_nla(nla, maxtype, policy);
+			if (err < 0)
+				goto errout;
+		}
+
+		tb[idx] = nla;
+		idx++;
+	}
+
+errout:
+	return err;
+}
+
 /**
  * Create attribute index based on a stream of attributes.
  * @arg tb		Index array to be filled (maxtype+1 elements).
@@ -193,3 +239,62 @@ int libbpf_nla_dump_errormsg(struct nlmsghdr *nlh)
 
 	return 0;
 }
+
+struct nlattr *libbpf_nla_next(struct nlattr *current)
+{
+	return current + NLA_ALIGN(current->nla_len) / sizeof(struct nlattr);
+}
+
+struct nlattr *libbpf_nla_nest_start(struct nlattr *start, int attrtype)
+{
+	start->nla_len = NLA_HDRLEN;
+	start->nla_type = attrtype | NLA_F_NESTED;
+	return start + 1;
+}
+
+int libbpf_nla_nest_end(struct nlattr *start, struct nlattr *next)
+{
+	start->nla_len += (unsigned char *)next  - (unsigned char *)start - NLA_HDRLEN;
+	return start->nla_len;
+}
+
+struct nlattr *libbpf_nla_put_u32(struct nlattr *start, int attrtype, uint32_t val)
+{
+	struct nlattr *next = start + 1;
+
+	start->nla_type = attrtype;
+	start->nla_len = NLA_HDRLEN + NLA_ALIGN(sizeof(uint32_t));
+	memcpy((char *)next, &val, sizeof(uint32_t));
+
+	return next + 1;
+}
+
+struct nlattr *libbpf_nla_put_str(struct nlattr *start, int attrtype,
+				  const char *string, int max_len)
+{
+	struct nlattr *next = start + 1;
+	size_t len = max_len > 0 ? strnlen(string, max_len - 1) : 0;
+	char *ptr = ((char *)next) + len;
+
+	start->nla_type = attrtype;
+	start->nla_len = NLA_HDRLEN + NLA_ALIGN(len + 1);
+	strncpy((char *)next, string, len);
+
+	for (size_t idx = len; idx < start->nla_len; ++idx, ptr++)
+		*ptr = '\0';
+
+	return libbpf_nla_next(start);
+}
+
+struct nlattr *libbpf_nla_put_flag(struct nlattr *start, int attrtype)
+{
+	start->nla_type = attrtype;
+	start->nla_len = NLA_HDRLEN;
+
+	return start + 1;
+}
+
+int libbpf_nla_attrs_length(struct nlattr *start, struct nlattr *next)
+{
+	return ((unsigned char *)next  - (unsigned char *)start);
+}
diff --git a/tools/lib/bpf/nlattr.h b/tools/lib/bpf/nlattr.h
index 6cc3ac91690f..93e18accfce5 100644
--- a/tools/lib/bpf/nlattr.h
+++ b/tools/lib/bpf/nlattr.h
@@ -76,6 +76,11 @@ static inline uint8_t libbpf_nla_getattr_u8(const struct nlattr *nla)
 	return *(uint8_t *)libbpf_nla_data(nla);
 }
 
+static inline uint16_t libbpf_nla_getattr_u16(const struct nlattr *nla)
+{
+	return *(uint16_t *)libbpf_nla_data(nla);
+}
+
 static inline uint32_t libbpf_nla_getattr_u32(const struct nlattr *nla)
 {
 	return *(uint32_t *)libbpf_nla_data(nla);
@@ -100,7 +105,24 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 int libbpf_nla_parse_nested(struct nlattr *tb[], int maxtype,
 			    struct nlattr *nla,
 			    struct libbpf_nla_policy *policy);
+int libbpf_nla_parse_table(struct nlattr *tb[], int elem, struct nlattr *head,
+			   int type, struct libbpf_nla_policy *policy);
 
 int libbpf_nla_dump_errormsg(struct nlmsghdr *nlh);
 
+struct nlattr *libbpf_nla_next(struct nlattr *current);
+
+struct nlattr *libbpf_nla_nest_start(struct nlattr *start, int attrtype);
+
+int libbpf_nla_nest_end(struct nlattr *start, struct nlattr *next);
+
+struct nlattr *libbpf_nla_put_u32(struct nlattr *start, int attrtype, uint32_t val);
+
+struct nlattr *libbpf_nla_put_str(struct nlattr *start, int attrtype,
+				  const char *string, int max_len);
+
+struct nlattr *libbpf_nla_put_flag(struct nlattr *start, int attrtype);
+
+int libbpf_nla_attrs_length(struct nlattr *start, struct nlattr *next);
+
 #endif /* __LIBBPF_NLATTR_H */
-- 
2.20.1

