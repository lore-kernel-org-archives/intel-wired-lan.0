From: John Fastabend <john.r.fastabend@intel.com>
Date: Mon, 18 May 2015 15:03:27 -0700
Subject: [Intel-wired-lan] [net-next PATCH 1/8] flow: create nl interface to
 wrap low level flow msg details
Message-ID: <20150518220327.14831.64876.stgit@azvasil-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: John Fastabend <john.r.fastabend@intel.com>

Some low-level functions that can be used to interface with
API from other programs without having to invoke NETLINK
primitives.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 include/flowlib_nl.h |   75 ++++++
 lib/Makefile.am      |    2 
 lib/flowlib_nl.c     |  657 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/flow.c           |  266 +++-----------------
 4 files changed, 773 insertions(+), 227 deletions(-)
 create mode 100644 include/flowlib_nl.h
 create mode 100644 lib/flowlib_nl.c

diff --git a/include/flowlib_nl.h b/include/flowlib_nl.h
new file mode 100644
index 0000000..1aeddae
--- /dev/null
+++ b/include/flowlib_nl.h
@@ -0,0 +1,75 @@
+/*******************************************************************************
+
+  Flow Library - Helpers for working on Flow API
+  Copyright(c) 2014 Intel Corporation.
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+  Author: John Fastabend <john.r.fastabend@intel.com>
+
+*******************************************************************************/
+#ifndef _FLOWLIB_NL_H
+#define _FLOWLIB_NL_H
+struct flow_msg {
+	void *msg;
+	struct nl_msg *nlbuf;
+	uint32_t seq;
+};
+
+struct nl_sock *flow_nl_get_socket(void);
+
+struct net_flow_hdr *flow_nl_get_headers(struct nl_sock *nsd, uint32_t pid,
+					 unsigned int ifindex, int family);
+struct net_flow_action *flow_nl_get_actions(struct nl_sock *nsd, uint32_t pid,
+					    unsigned int ifindex, int family);
+struct net_flow_tbl *flow_nl_get_tables(struct nl_sock *nsd, uint32_t pid,
+					unsigned int ifindex, int family);
+struct net_flow_hdr_node *flow_nl_get_hdr_graph(struct nl_sock *nsd,
+						uint32_t pid,
+						unsigned int ifindex,
+						int family);
+struct net_flow_tbl_node *flow_nl_get_tbl_graph(struct nl_sock *nsd,
+						uint32_t pid,
+						unsigned int ifindex,
+						int family);
+
+int flow_nl_set_flows(struct nl_sock *nsd, uint32_t pid,
+		      unsigned int ifindex, int family,
+		      struct net_flow_flow *flow);
+int flow_nl_create_table(struct nl_sock *nsd, uint32_t pid,
+			 unsigned int ifindex, int family,
+			 struct net_flow_tbl *table);
+
+uint32_t flow_nl_find_header(struct net_flow_hdr *hdr,
+			     struct net_flow_hdr *search);
+uint32_t flow_nl_find_action_by_name(char *name,
+				     struct net_flow_action *action);
+uint32_t flow_nl_find_instance(struct net_flow_hdr_node *graph,
+			       uint32_t uid, uint32_t next);
+uint32_t flow_nl_find_table_with_action(struct net_flow_tbl *tbls,
+					uint32_t action, uint32_t next);
+
+void flow_nl_free_msg(struct flow_msg *msg);
+struct flow_msg *flow_nl_wrap_msg(struct nlmsghdr *buf);
+struct flow_msg *flow_nl_recv_msg(struct nl_sock *nsd, int *err);
+int flow_nl_table_cmd_to_type(FILE *fp, bool print, int valid,
+			      struct nlattr *tb[]);
+struct flow_msg *flow_nl_alloc_msg(uint8_t type, uint32_t pid, int flags,
+				   int size, int family);
+struct flow_msg *flow_nl_get_msg(struct nl_sock *nsd, uint8_t cmd, uint32_t pid,
+				 unsigned int ifindex, int family);
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 5a15bf8..8f815ca 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -36,7 +36,7 @@ libflowies_la_CFLAGS = $(AM_CFLAGS) $(IES_CFLAGS) $(CFLAGS)
 libflowies_la_LDFLAGS = -release @FLOW_API_VERSION@
 
 lib_LTLIBRARIES += libflow.la
-libflow_la_SOURCES = flowlib.c
+libflow_la_SOURCES = flowlib_nl.c flowlib.c
 libflow_la_LDFLAGS = -release @FLOW_API_VERSION@
 
 lib_LTLIBRARIES += libflowd.la
diff --git a/lib/flowlib_nl.c b/lib/flowlib_nl.c
new file mode 100644
index 0000000..e246768
--- /dev/null
+++ b/lib/flowlib_nl.c
@@ -0,0 +1,657 @@
+/*******************************************************************************
+
+  Functional Flow API
+  Copyright(c) 2014 Intel Corporation.
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+  Author: John Fastabend <john.r.fastabend@intel.com>
+
+*******************************************************************************/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/queue.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <getopt.h>
+
+#include <libnl3/netlink/netlink.h>
+#include <libnl3/netlink/socket.h>
+#include <libnl3/netlink/genl/genl.h>
+#include <libnl3/netlink/genl/ctrl.h>
+#include <libnl3/netlink/route/link.h>
+
+#include <linux/if_ether.h>
+
+#include "if_flow.h"
+#include "flowlib.h"
+#include "flowlib_nl.h"
+
+struct nl_cache *link_cache;
+int verbose = 0;
+static struct nla_policy flow_get_tables_policy[NET_FLOW_MAX+1] = {
+	[NET_FLOW_IDENTIFIER_TYPE] = { .type = NLA_U32 },
+	[NET_FLOW_IDENTIFIER]	= { .type = NLA_U32 },
+	[NET_FLOW_TABLES]	= { .type = NLA_NESTED },
+	[NET_FLOW_HEADERS]	= { .type = NLA_NESTED },
+	[NET_FLOW_ACTIONS] 	= { .type = NLA_NESTED },
+	[NET_FLOW_HEADER_GRAPH]	= { .type = NLA_NESTED },
+	[NET_FLOW_TABLE_GRAPH]	= { .type = NLA_NESTED },
+	[NET_FLOW_FLOWS]	= { .type = NLA_NESTED },
+};
+
+static void pfprintf(FILE *fp, bool p, const char *format, ...)
+{
+	va_list args;
+	va_start(args, format);
+
+	if (p)
+		vfprintf(fp, format, args);
+
+	va_end(args);
+}
+
+void flow_nl_free_msg(struct flow_msg *msg)
+{
+	if (msg->nlbuf)
+		nlmsg_free(msg->nlbuf);
+	else
+		free(msg->msg);
+	free(msg);
+}
+
+struct nl_sock *flow_nl_get_socket(void)
+{
+	struct nl_sock *nsd = nl_socket_alloc();
+
+	nl_connect(nsd, NETLINK_GENERIC);
+
+	return nsd;
+}
+
+struct net_flow_hdr *flow_nl_get_headers(struct nl_sock *nsd, uint32_t pid,
+					 unsigned int ifindex, int family)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_GET_HEADERS;
+	struct net_flow_hdr *hdrs = NULL;
+	struct flow_msg *msg;
+
+	msg = flow_nl_get_msg(nsd, cmd, pid, ifindex, family);
+
+	if (msg) {
+		struct nlmsghdr *nlh = msg->msg;
+		struct nlattr *tb[NET_FLOW_MAX+1];
+		int err;
+
+		err = genlmsg_parse(nlh, 0, tb,
+				    NET_FLOW_MAX, flow_get_tables_policy);
+		if (err < 0) {
+			fprintf(stderr, "Warning unable to parse get tables msg\n");
+			goto out;
+		}
+
+		if (flow_nl_table_cmd_to_type(stdout, true,
+					      NET_FLOW_HEADERS, tb))
+			goto out;
+
+		if (tb[NET_FLOW_HEADERS])
+			flow_get_headers(stdout, verbose,
+					 tb[NET_FLOW_HEADERS], &hdrs);
+	}
+	return hdrs;
+out:
+	flow_nl_free_msg(msg);
+	return NULL;
+}
+
+struct net_flow_action *flow_nl_get_actions(struct nl_sock *nsd, uint32_t pid,
+					    unsigned int ifindex, int family)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_GET_ACTIONS;
+	struct net_flow_action *actions = NULL;
+	struct flow_msg *msg;
+
+	msg = flow_nl_get_msg(nsd, cmd, pid, ifindex, family);
+
+	if (msg) {
+		struct nlmsghdr *nlh = msg->msg;
+		struct nlattr *tb[NET_FLOW_MAX+1];
+		int err;
+
+		err = genlmsg_parse(nlh, 0, tb,
+				    NET_FLOW_MAX, flow_get_tables_policy);
+		if (err < 0) {
+			fprintf(stderr, "Warning unable to parse get tables msg\n");
+			goto out;
+		}
+
+		if (flow_nl_table_cmd_to_type(stdout, true,
+					      NET_FLOW_ACTIONS, tb))
+			goto out;
+
+		if (tb[NET_FLOW_ACTIONS])
+			flow_get_actions(stdout, verbose,
+					 tb[NET_FLOW_ACTIONS], &actions);
+	}
+	return actions;
+out:
+	flow_nl_free_msg(msg);
+	return NULL;
+}
+
+struct net_flow_tbl *flow_nl_get_tables(struct nl_sock *nsd, uint32_t pid,
+					unsigned int ifindex, int family)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_GET_TABLES;
+	struct net_flow_tbl *tables = NULL;
+	struct flow_msg *msg;
+
+	msg = flow_nl_get_msg(nsd, cmd, pid, ifindex, family);
+
+	if (msg) {
+		struct nlattr *tb[NET_FLOW_MAX+1];
+		struct nlmsghdr *nlh = msg->msg;
+		int err;
+
+		err = genlmsg_parse(nlh, 0, tb,
+				    NET_FLOW_MAX, flow_get_tables_policy);
+		if (err < 0) {
+			fprintf(stderr, "Warning unable to parse get tables msg\n");
+			goto out;
+		}
+
+		if (flow_nl_table_cmd_to_type(stdout, true,
+					      NET_FLOW_TABLES, tb))
+			goto out;
+
+		if (tb[NET_FLOW_TABLES])
+			flow_get_tables(stdout, verbose,
+					tb[NET_FLOW_TABLES], &tables);
+	}
+	return tables;
+out:
+	flow_nl_free_msg(msg);
+	return NULL;
+}
+
+struct net_flow_hdr_node *flow_nl_get_hdr_graph(struct nl_sock *nsd,
+						uint32_t pid,
+						unsigned int ifindex,
+						int family)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_GET_HDR_GRAPH;
+	struct net_flow_hdr_node *hdr_nodes = NULL;
+	struct flow_msg *msg;
+
+	msg = flow_nl_get_msg(nsd, cmd, pid, ifindex, family);
+
+	if (msg) {
+		struct nlmsghdr *nlh = msg->msg;
+		struct nlattr *tb[NET_FLOW_MAX+1];
+		int err;
+
+		err = genlmsg_parse(nlh, 0, tb,
+				    NET_FLOW_MAX, flow_get_tables_policy);
+		if (err < 0) {
+			fprintf(stderr, "Warning unable to parse get tables msg\n");
+			goto out;
+		}
+
+		if (flow_nl_table_cmd_to_type(stdout, true,
+					      NET_FLOW_HEADER_GRAPH, tb))
+			goto out;
+
+		if (tb[NET_FLOW_HEADER_GRAPH])
+			flow_get_hdrs_graph(stdout, verbose,
+					    tb[NET_FLOW_HEADER_GRAPH],
+					    &hdr_nodes);
+	}
+
+	return hdr_nodes;
+out:
+	flow_nl_free_msg(msg);
+	return NULL;
+}
+
+struct net_flow_tbl_node *flow_nl_get_tbl_graph(struct nl_sock*nsd,
+						uint32_t pid,
+						unsigned int ifindex,
+						int family)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_GET_TABLE_GRAPH;
+	struct net_flow_tbl_node *nodes = NULL;
+	struct flow_msg *msg;
+
+	msg = flow_nl_get_msg(nsd, cmd, pid, ifindex, family);
+
+	if (msg) {
+		struct nlmsghdr *nlh = msg->msg;
+		struct nlattr *tb[NET_FLOW_MAX+1];
+		int err;
+
+		err = genlmsg_parse(nlh, 0, tb,
+				    NET_FLOW_MAX, flow_get_tables_policy);
+		if (err < 0) {
+			fprintf(stderr, "Warning unable to parse get tables msg\n");
+			goto out;
+		}
+
+		if (flow_nl_table_cmd_to_type(stdout, true,
+					      NET_FLOW_TABLE_GRAPH, tb))
+			goto out;
+
+		if (tb[NET_FLOW_TABLE_GRAPH])
+			flow_get_tbl_graph(stdout, verbose,
+					   tb[NET_FLOW_TABLE_GRAPH], &nodes);
+	}
+
+	return nodes;
+out:
+	flow_nl_free_msg(msg);
+	return NULL;
+}
+
+int flow_nl_set_flows(struct nl_sock *nsd, uint32_t pid,
+		      unsigned int ifindex, int family,
+		      struct net_flow_flow *flow)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_SET_FLOWS;
+	struct nlattr *tb[NET_FLOW_MAX+1];
+	struct flow_msg *msg;
+	struct nlmsghdr *nlh;
+	struct nlattr *flows;
+	sigset_t bs;
+	int err = 0;
+
+	pp_flow(stdout, true, flow);
+
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	if (!msg) {
+		fprintf(stderr, "Error: Allocation failure\n");
+		return -ENOMSG;
+	}
+
+	if (nla_put_u32(msg->nlbuf,
+			NET_FLOW_IDENTIFIER_TYPE,
+			NET_FLOW_IDENTIFIER_IFINDEX) ||
+	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
+		fprintf(stderr, "Error: Identifier put failed\n");
+		return -EMSGSIZE;
+	}
+
+	err = flow_put_flow_error(msg->nlbuf, NET_FLOW_FLOWS_ERROR_CONT_LOG);
+	if (err)
+		return err;
+
+	flows = nla_nest_start(msg->nlbuf, NET_FLOW_FLOWS);
+	if (!flows)
+		return -EMSGSIZE;
+	flow_put_flow(msg->nlbuf, flow);
+	nla_nest_end(msg->nlbuf, flows);
+
+	nl_send_auto(nsd, msg->nlbuf);
+
+	/* message sent handle recv */
+	sigemptyset(&bs);
+	sigaddset(&bs, SIGINT);
+	sigprocmask(SIG_UNBLOCK, &bs, NULL);
+
+	msg = flow_nl_recv_msg(nsd, &err);
+	sigprocmask(SIG_BLOCK, &bs, NULL);
+
+	if (!msg)
+		return -EINVAL;
+
+	nlh = msg->msg;
+	err = genlmsg_parse(nlh, 0, tb, NET_FLOW_MAX, flow_get_tables_policy);
+	if (err < 0) {
+		fprintf(stderr, "Warning unable to parse set flows msg\n");
+		flow_nl_free_msg(msg);
+		return err;
+	}
+
+	err = flow_nl_table_cmd_to_type(stdout, true, 0, tb);
+	if (err)
+		return err;
+
+	if (tb[NET_FLOW_FLOWS]) {
+		fprintf(stderr, "Failed to set:\n");
+		flow_get_flows(stdout, verbose, tb[NET_FLOW_FLOWS], NULL);
+		flow_nl_free_msg(msg);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int flow_nl_create_table(struct nl_sock *nsd, uint32_t pid,
+			 unsigned int ifindex, int family,
+			 struct net_flow_tbl *table)
+{
+	uint8_t cmd = NET_FLOW_TABLE_CMD_CREATE_TABLE;
+	struct nlattr *tb[NET_FLOW_MAX+1];
+	struct nlattr *nest, *nest1;
+	struct nlmsghdr *nlh;
+	struct flow_msg *msg;
+	sigset_t bs;
+	int err = 0;
+
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	if (!msg) {
+		fprintf(stderr, "Error: Allocation failure\n");
+		return -ENOMSG;
+	}
+
+	if (nla_put_u32(msg->nlbuf,
+			NET_FLOW_IDENTIFIER_TYPE,
+			NET_FLOW_IDENTIFIER_IFINDEX) ||
+	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
+		fprintf(stderr, "Error: Identifier put failed\n");
+		return -EMSGSIZE;
+	}
+
+	nest = nla_nest_start(msg->nlbuf, NET_FLOW_TABLES);
+	if (!nest)
+		return -EMSGSIZE;
+	nest1 = nla_nest_start(msg->nlbuf, NET_FLOW_TABLE);
+	flow_put_table(msg->nlbuf, table);
+	nla_nest_end(msg->nlbuf, nest1);
+	nla_nest_end(msg->nlbuf, nest);
+	nl_send_auto(nsd, msg->nlbuf);
+
+	sigemptyset(&bs);
+	sigaddset(&bs, SIGINT);
+	sigprocmask(SIG_UNBLOCK, &bs, NULL);
+
+	msg = flow_nl_recv_msg(nsd, &err);
+	sigprocmask(SIG_BLOCK, &bs, NULL);
+
+	if (!msg)
+		return -EINVAL;
+
+	nlh = msg->msg;
+	err = genlmsg_parse(nlh, 0, tb, NET_FLOW_MAX, flow_get_tables_policy);
+	if (err < 0) {
+		fprintf(stderr, "Warning unable to parse create table msg\n");
+		flow_nl_free_msg(msg);
+		return err;
+	}
+	return 0;
+}
+
+uint32_t flow_nl_find_header(struct net_flow_hdr *hdr,
+			     struct net_flow_hdr *search)
+{
+	uint32_t i, j;
+
+	for (i = 0; search[i].uid; i++) {
+		if (hdr->field_sz != search[i].field_sz)
+			continue;
+
+		for (j = 0; j < hdr->field_sz; j++) {
+			if (hdr->fields[j].bitwidth != search[i].fields[j].bitwidth)
+				continue;
+		}
+
+		if (j == hdr->field_sz)
+			return search[i].uid;
+	}
+	return 0;
+}
+
+uint32_t flow_nl_find_action_by_name(char *name, struct net_flow_action *acts)
+{
+	uint32_t i;
+
+	for (i = 0; acts[i].uid; i++) {
+		if (strcmp(name, acts[i].name) == 0)
+			return acts[i].uid;
+	}
+
+	return 0;
+}
+
+uint32_t flow_nl_find_instance(struct net_flow_hdr_node *graph,
+			       uint32_t uid, uint32_t next)
+{
+	uint32_t i, j;
+
+	for (i = 0; graph[i].uid; i++) {
+		if (graph[i].uid < next)
+			continue;
+
+		for (j = 0; graph[i].hdrs[j]; j++) {
+			if (graph[i].hdrs[j] != uid)
+				continue;
+
+			return graph[i].uid;
+		}
+	}
+
+	return 0;
+}
+
+uint32_t flow_nl_find_table_with_action(struct net_flow_tbl *tbls,
+					uint32_t action, uint32_t next)
+{
+	uint32_t i, j;
+
+	for (i = 0; tbls[i].uid; i++) {
+		if (i < next)
+			continue;
+
+		for (j = 0; tbls[i].actions[j]; j++) {
+			if (tbls[i].actions[j] == action)
+				return tbls[i].uid;
+		}
+	}
+
+	return 0;
+}
+
+struct flow_msg *flow_nl_wrap_msg(struct nlmsghdr *buf)
+{
+	struct flow_msg *msg;
+
+	msg = (struct flow_msg *) malloc(sizeof(struct flow_msg));
+	if (msg) {
+		msg->msg = buf;
+		msg->nlbuf = NULL;
+	}
+
+	return msg;
+}
+
+static void flow_nl_handle_error(struct nlmsgerr *errmsg)
+{
+	fprintf(stderr, "Error processing request: %s\n",
+		strerror(errmsg->error));
+}
+
+struct flow_msg *flow_nl_recv_msg(struct nl_sock *nsd, int *err)
+{
+	static unsigned char *buf;
+	struct flow_msg *msg;
+	struct genlmsghdr *glm;
+	struct sockaddr_nl nla;
+	int type;
+	int rc;
+
+	*err = 0;
+
+	do {
+		rc = nl_recv(nsd, &nla, &buf, NULL);
+		if (rc < 0) {
+			switch (errno) {
+			case EINTR:
+				return NULL;
+			default:
+				perror("Receive operation failed:");
+				return NULL;
+			}
+		}
+	} while (rc == 0);
+
+	msg = flow_nl_wrap_msg((struct nlmsghdr *)buf);
+	if (!msg) {
+		fprintf(stderr, "Error: Message is empty\n");
+		free(buf);
+		return NULL;
+	}
+	type = ((struct nlmsghdr *)msg->msg)->nlmsg_type;
+
+	/*
+	 * Note the NLMSG_ERROR is overloaded
+	 * Its also used to deliver ACKs
+	 */
+	if (type == NLMSG_ERROR) {
+		struct nlmsgerr *errm = nlmsg_data(msg->msg);
+
+		if (errm->error) {
+			flow_nl_handle_error(errm);
+			flow_nl_free_msg(msg);
+			return NULL;
+		}
+
+		flow_nl_free_msg(msg);
+		return NULL;
+	}
+
+	glm = nlmsg_data(msg->msg);
+	type = glm->cmd;
+
+	if (type < 0 || type > NET_FLOW_CMD_MAX) {
+		fprintf(stderr, "Received message of unknown type %d\n", type);
+		flow_nl_free_msg(msg);
+		return NULL;
+	}
+
+	return msg;
+}
+
+int flow_nl_table_cmd_to_type(FILE *fp, bool print, int valid,
+			      struct nlattr *tb[])
+{
+	unsigned int type, ifindex;
+	char iface[IFNAMSIZ];
+
+	if (!tb[NET_FLOW_IDENTIFIER_TYPE]) {
+		fprintf(stderr,
+			"Warning: received flow msg without identifier type!\n");
+		return -EINVAL;
+	}
+	if (!tb[NET_FLOW_IDENTIFIER]) {
+		fprintf(stderr,
+			"Warning: received flow msg without identifier!\n");
+		return -EINVAL;
+	}
+
+	if (valid > 0 && !tb[valid]){
+		fprintf(stderr, "Warning received cmd without valid attribute expected %i\n", valid);
+		return -ENOMSG;
+	}
+
+	if (nla_len(tb[NET_FLOW_IDENTIFIER_TYPE]) < (int)sizeof(type)) {
+		fprintf(stderr, "Warning invalid identifier type len\n");
+		return -EINVAL;
+	}
+
+	type = nla_get_u32(tb[NET_FLOW_IDENTIFIER_TYPE]);
+
+	switch (type) {
+	case NET_FLOW_IDENTIFIER_IFINDEX:
+		ifindex = nla_get_u32(tb[NET_FLOW_IDENTIFIER]);
+		rtnl_link_i2name(link_cache, (int)ifindex, iface, IFNAMSIZ);
+		pfprintf(fp, print, "%s (%u):\n", iface, ifindex);
+		break;
+	default:
+		fprintf(stderr, "Warning unknown interface identifier type %i\n", type);
+		break;
+	}
+
+	return 0;
+}
+
+struct flow_msg *flow_nl_alloc_msg(uint8_t type, uint32_t pid,
+				   int flags, int size, int family)
+{
+	struct flow_msg *msg;
+	static uint32_t seq = 0;
+
+	msg = (struct flow_msg *) malloc(sizeof(struct flow_msg));
+	if (!msg)
+		return NULL;
+
+	msg->nlbuf = nlmsg_alloc();
+
+	msg->msg = genlmsg_put(msg->nlbuf, 0, seq, family, (int)size, flags,
+			       type, NET_FLOW_GENL_VERSION);
+
+	msg->seq = seq++;
+
+	if (pid) {
+		struct nl_msg *nl_msg = msg->nlbuf;
+		struct sockaddr_nl nladdr = {
+			.nl_family = AF_NETLINK,
+			.nl_pid = pid,
+			.nl_groups = 0,
+		};
+
+		nlmsg_set_dst(nl_msg, &nladdr);
+	}
+	return msg;
+}
+
+struct flow_msg *flow_nl_get_msg(struct nl_sock *nsd, uint8_t cmd, uint32_t pid,
+				 unsigned int ifindex, int family)
+{
+	struct flow_msg *msg;
+	sigset_t bs;
+	int err;
+
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	if (!msg) {
+		fprintf(stderr, "Error: Allocation failure\n");
+		return NULL;
+	}
+
+	nla_put_u32(msg->nlbuf,
+		    NET_FLOW_IDENTIFIER_TYPE,
+		    NET_FLOW_IDENTIFIER_IFINDEX);
+	nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex);
+
+	nl_send_auto(nsd, msg->nlbuf);
+
+	sigemptyset(&bs);
+	sigaddset(&bs, SIGINT);
+	sigprocmask(SIG_UNBLOCK, &bs, NULL);
+
+	msg = flow_nl_recv_msg(nsd, &err);
+	sigprocmask(SIG_BLOCK, &bs, NULL);
+	return msg;
+}
diff --git a/src/flow.c b/src/flow.c
index f24537d..43c30c7 100644
--- a/src/flow.c
+++ b/src/flow.c
@@ -55,6 +55,7 @@
 
 #include "if_flow.h"
 #include "flowlib.h"
+#include "flowlib_nl.h"
 
 #ifdef PRIx64
 #undef PRIx64
@@ -72,18 +73,6 @@
 #endif /* SCNu64 */
 static struct nl_sock *nsd;
 
-struct flow_msg {
-	void *msg;
-	struct nl_msg *nlbuf;
-	uint32_t seq;
-};
-
-static struct flow_msg *
-alloc_flow_msg(uint8_t type, uint32_t pid, int flags, int size, int family);
-
-static struct flow_msg *wrap_netlink_msg(struct nlmsghdr *buf);
-static void free_flow_msg(struct flow_msg *msg);
-static struct flow_msg *recv_flow_msg(int *err);
 static void process_rx_message(int verbose);
 
 static int
@@ -225,71 +214,6 @@ static void get_flows_usage(char *progname)
 }
 
 
-static void pfprintf(FILE *fp, bool p, const char *format, ...)
-{
-	va_list args;
-
-	va_start(args, format);
-
-	if (p)
-		vfprintf(fp, format, args);
-
-	va_end(args);
-}
-
-struct flow_msg *
-alloc_flow_msg(uint8_t type, uint32_t pid, int flags, int size, int family)
-{
-	struct flow_msg *msg;
-	static uint32_t seq;
-
-	msg = malloc(sizeof(*msg));
-	if (!msg)
-		return NULL;
-
-	msg->nlbuf = nlmsg_alloc();
-
-	msg->msg = genlmsg_put(msg->nlbuf, 0, seq, family, (int)size, flags,
-			type, NET_FLOW_GENL_VERSION);
-
-	msg->seq = seq++;
-
-	if (pid) {
-		struct nl_msg *nl_msg = msg->nlbuf;
-		struct sockaddr_nl nladdr = {
-			.nl_family = AF_NETLINK,
-			.nl_pid = pid,
-			.nl_groups = 0,
-		};
-
-		nlmsg_set_dst(nl_msg, &nladdr);
-	}
-
-	return msg;
-}
-
-struct flow_msg *wrap_netlink_msg(struct nlmsghdr *buf)
-{
-	struct flow_msg *msg;
-
-	msg = (struct flow_msg *) malloc(sizeof(struct flow_msg));
-	if (msg) {
-		msg->msg = buf;
-		msg->nlbuf = NULL;
-	}
-
-	return msg;
-}
-
-void free_flow_msg(struct flow_msg *msg)
-{
-	if (msg->nlbuf)
-		nlmsg_free(msg->nlbuf);
-	else
-		free(msg->msg);
-	free(msg);
-}
-
 static struct nla_policy flow_get_tables_policy[NET_FLOW_MAX+1] = {
 	[NET_FLOW_IDENTIFIER_TYPE] = { .type = NLA_U32 },
 	[NET_FLOW_IDENTIFIER]	= { .type = NLA_U32 },
@@ -304,49 +228,6 @@ static struct nla_policy flow_get_tables_policy[NET_FLOW_MAX+1] = {
 struct nl_cache *link_cache;
 
 static int
-flow_table_cmd_to_type(FILE *fp, bool p, int valid, struct nlattr *tb[])
-{
-	unsigned int type, ifindex;
-	char iface[IFNAMSIZ];
-
-	if (!tb[NET_FLOW_IDENTIFIER_TYPE]) {
-		fprintf(stderr,
-			"Warning: received flow msg without identifier type!\n");
-		return -EINVAL;
-	}
-	if (!tb[NET_FLOW_IDENTIFIER]) {
-		fprintf(stderr,
-			"Warning: received flow msg without identifier!\n");
-		return -EINVAL;
-	}
-
-	if (valid > 0 && !tb[valid]) {
-		fprintf(stderr, "Warning received cmd without valid attribute expected %i\n", valid);
-		return -ENOMSG;
-	}
-
-	if (nla_len(tb[NET_FLOW_IDENTIFIER_TYPE]) < (int)sizeof(type)) {
-		fprintf(stderr, "Warning invalid identifier type len\n");
-		return -EINVAL;
-	}
-
-	type = nla_get_u32(tb[NET_FLOW_IDENTIFIER_TYPE]);
-
-	switch (type) {
-	case NET_FLOW_IDENTIFIER_IFINDEX:
-		ifindex = nla_get_u32(tb[NET_FLOW_IDENTIFIER]);
-		rtnl_link_i2name(link_cache, (int)ifindex, iface, IFNAMSIZ);
-		pfprintf(fp, p, "%s (%u):\n", iface, ifindex);
-		break;
-	default:
-		fprintf(stderr, "Warning unknown interface identifier type %i\n", type);
-		break;
-	}
-
-	return 0;
-}
-
-static int
 flow_macaddr2u64(__u64 *dst, size_t n, char *src)
 {
 	__u8 tmp[ETH_ALEN];
@@ -379,7 +260,7 @@ static void flow_table_cmd_get_tables(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	if (flow_table_cmd_to_type(stdout, false, NET_FLOW_TABLES, tb))
+	if (flow_nl_table_cmd_to_type(stdout, false, NET_FLOW_TABLES, tb))
 		return;
 
 	if (tb[NET_FLOW_TABLES])
@@ -398,7 +279,7 @@ static void flow_table_cmd_get_headers(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	if (flow_table_cmd_to_type(stdout, false, NET_FLOW_HEADERS, tb))
+	if (flow_nl_table_cmd_to_type(stdout, false, NET_FLOW_HEADERS, tb))
 		return;
 
 	if (tb[NET_FLOW_HEADERS])
@@ -417,7 +298,7 @@ static void flow_table_cmd_get_actions(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	if (flow_table_cmd_to_type(stdout, false, NET_FLOW_ACTIONS, tb))
+	if (flow_nl_table_cmd_to_type(stdout, false, NET_FLOW_ACTIONS, tb))
 		return;
 
 	if (tb[NET_FLOW_ACTIONS])
@@ -436,7 +317,7 @@ static void flow_table_cmd_get_headers_graph(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	if (flow_table_cmd_to_type(stdout, false, NET_FLOW_HEADER_GRAPH, tb))
+	if (flow_nl_table_cmd_to_type(stdout, false, NET_FLOW_HEADER_GRAPH, tb))
 		return;
 
 	if (tb[NET_FLOW_HEADER_GRAPH])
@@ -456,7 +337,7 @@ static void flow_table_cmd_get_table_graph(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	if (flow_table_cmd_to_type(stdout, false, NET_FLOW_TABLE_GRAPH, tb))
+	if (flow_nl_table_cmd_to_type(stdout, false, NET_FLOW_TABLE_GRAPH, tb))
 		return;
 
 	if (tb[NET_FLOW_TABLE_GRAPH])
@@ -476,7 +357,7 @@ static void flow_table_cmd_get_flows(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	err = flow_table_cmd_to_type(stdout, false, 0, tb);
+	err = flow_nl_table_cmd_to_type(stdout, false, 0, tb);
 	if (err == -ENOMSG) {
 		fprintf(stdout, "Table empty\n");
 		return;
@@ -501,7 +382,7 @@ static void flow_table_cmd_set_flows(struct flow_msg *msg, int verbose)
 		return;
 	}
 
-	err = flow_table_cmd_to_type(stdout, false, 0, tb);
+	err = flow_nl_table_cmd_to_type(stdout, false, 0, tb);
 	if (err)
 		return;
 
@@ -569,73 +450,6 @@ flow_table_cmd_destroy_table(struct flow_msg *msg, int verbose __unused)
 	}
 }
 
-static void handle_error(struct nlmsgerr *errmsg)
-{
-	fprintf(stderr, "Error processing request: %s\n",
-		strerror(errmsg->error));
-}
-
-struct flow_msg *recv_flow_msg(int *err)
-{
-	static unsigned char *buf;
-	struct flow_msg *msg;
-	struct genlmsghdr *glm;
-	struct sockaddr_nl nla;
-	int type;
-	int rc;
-
-	*err = 0;
-
-	do {
-		rc = nl_recv(nsd, &nla, &buf, NULL);
-		if (rc < 0) {
-			switch (errno) {
-			case EINTR:
-				return NULL;
-			default:
-				perror("Receive operation failed:");
-				return NULL;
-			}
-		}
-	} while (rc == 0);
-
-	msg = wrap_netlink_msg((struct nlmsghdr *)buf);
-	if (msg == NULL) {
-		fprintf(stderr, "Error: Message is empty\n");
-		free(buf);
-		return NULL;
-	}
-	type = ((struct nlmsghdr *)msg->msg)->nlmsg_type;
-
-	/*
-	 * Note the NLMSG_ERROR is overloaded
-	 * Its also used to deliver ACKs
-	 */
-	if (type == NLMSG_ERROR) {
-		struct nlmsgerr *errm = nlmsg_data(msg->msg);
-
-		if (errm->error) {
-			handle_error(errm);
-			free_flow_msg(msg);
-			return NULL;
-		}
-
-		free_flow_msg(msg);
-		return NULL;
-	}
-
-	glm = nlmsg_data(msg->msg);
-	type = glm->cmd;
-
-	if (type < 0 || type > NET_FLOW_CMD_MAX) {
-		fprintf(stderr, "Received message of unknown type %d\n", type);
-		free_flow_msg(msg);
-		return NULL;
-	}
-
-	return msg;
-}
-
 static void(*type_cb[NET_FLOW_CMD_MAX+1])(struct flow_msg *, int verbose) = {
 	flow_table_cmd_get_tables,
 	flow_table_cmd_get_headers,
@@ -667,7 +481,7 @@ void process_rx_message(int verbose)
 	 */
 	for (;;) {
 		sigprocmask(SIG_UNBLOCK, &bs, NULL);
-		msg = recv_flow_msg(&err);
+		msg = flow_nl_recv_msg(nsd, &err);
 		sigprocmask(SIG_BLOCK, &bs, NULL);
 
 		if (msg) {
@@ -675,7 +489,7 @@ void process_rx_message(int verbose)
 			struct genlmsghdr *glh = nlmsg_data(nlh);
 
 			if (nlh->nlmsg_type == NLMSG_DONE) {
-				free_flow_msg(msg);
+				flow_nl_free_msg(msg);
 				break;
 			}
 
@@ -683,10 +497,10 @@ void process_rx_message(int verbose)
 			type_cb[type](msg, verbose);
 
 			if (!(nlh->nlmsg_flags & NLM_F_MULTI)) {
-				free_flow_msg(msg);
+				flow_nl_free_msg(msg);
 				break;
 			}
-			free_flow_msg(msg);
+			flow_nl_free_msg(msg);
 		} else {
 			break;
 		}
@@ -1188,7 +1002,7 @@ flow_destroy_tbl_send(int verbose, uint32_t pid, int family,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMSG;
@@ -1198,13 +1012,13 @@ flow_destroy_tbl_send(int verbose, uint32_t pid, int family,
 			NET_FLOW_IDENTIFIER_IFINDEX) ||
 	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
 		fprintf(stderr, "Error: Identifier put failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
 	nest = nla_nest_start(msg->nlbuf, NET_FLOW_TABLES);
 	if (!nest) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 	nest1 = nla_nest_start(msg->nlbuf, NET_FLOW_TABLE);
@@ -1215,7 +1029,7 @@ flow_destroy_tbl_send(int verbose, uint32_t pid, int family,
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
 
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 
 }
@@ -1352,7 +1166,7 @@ flow_create_tbl_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMEM;
@@ -1362,13 +1176,13 @@ flow_create_tbl_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 			NET_FLOW_IDENTIFIER_IFINDEX) ||
 	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
 		fprintf(stderr, "Error: Identifier put failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
 	nest = nla_nest_start(msg->nlbuf, NET_FLOW_TABLES);
 	if (!nest) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 	nest1 = nla_nest_start(msg->nlbuf, NET_FLOW_TABLE);
@@ -1378,7 +1192,7 @@ flow_create_tbl_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 }
 
@@ -1453,7 +1267,7 @@ flow_del_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMSG;
@@ -1463,19 +1277,19 @@ flow_del_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 			NET_FLOW_IDENTIFIER_IFINDEX) ||
 	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
 		fprintf(stderr, "Error: Identifier put failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
 	err = flow_put_flow_error(msg->nlbuf, NET_FLOW_FLOWS_ERROR_ABORT);
 	if (err) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return err;
 	}
 
 	flows = nla_nest_start(msg->nlbuf, NET_FLOW_FLOWS);
 	if (!flows) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 	flow_put_flow(msg->nlbuf, &flow);
@@ -1484,7 +1298,7 @@ flow_del_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
 
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 }
 
@@ -1560,7 +1374,7 @@ flow_get_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMSG;
@@ -1570,20 +1384,20 @@ flow_get_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 			NET_FLOW_IDENTIFIER_IFINDEX) ||
 	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
 		fprintf(stderr, "Error: Identifier put failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
 	flows = nla_nest_start(msg->nlbuf, NET_FLOW_FLOWS);
 	if (!flows) {
 		fprintf(stderr, "Error: get_flows attributes failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -ENOMSG;
 	}
 
 	err = nla_put_u32(msg->nlbuf, NET_FLOW_TABLE_FLOWS_TABLE, tableid);
 	if (err) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
@@ -1591,7 +1405,7 @@ flow_get_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 		err = nla_put_u32(msg->nlbuf, NET_FLOW_TABLE_FLOWS_MINPRIO,
 				min);
 		if (err) {
-			free_flow_msg(msg);
+			flow_nl_free_msg(msg);
 			return err;
 		}
 	}
@@ -1600,7 +1414,7 @@ flow_get_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 		err = nla_put_u32(msg->nlbuf, NET_FLOW_TABLE_FLOWS_MAXPRIO,
 				max);
 		if (err) {
-			free_flow_msg(msg);
+			flow_nl_free_msg(msg);
 			return err;
 		}
 	}
@@ -1610,14 +1424,14 @@ flow_get_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 
 	err = flow_put_flow_error(msg->nlbuf, NET_FLOW_FLOWS_ERROR_ABORT);
 	if (err) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return err;
 	}
 
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
 
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 }
 
@@ -1723,7 +1537,7 @@ flow_set_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMSG;
@@ -1733,19 +1547,19 @@ flow_set_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 			NET_FLOW_IDENTIFIER_IFINDEX) ||
 	    nla_put_u32(msg->nlbuf, NET_FLOW_IDENTIFIER, ifindex)) {
 		fprintf(stderr, "Error: Identifier put failed\n");
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 
 	err = flow_put_flow_error(msg->nlbuf, NET_FLOW_FLOWS_ERROR_ABORT);
 	if (err) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return err;
 	}
 
 	flows = nla_nest_start(msg->nlbuf, NET_FLOW_FLOWS);
 	if (!flows) {
-		free_flow_msg(msg);
+		flow_nl_free_msg(msg);
 		return -EMSGSIZE;
 	}
 	flow_put_flow(msg->nlbuf, &flow);
@@ -1754,7 +1568,7 @@ flow_set_send(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
 
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 }
 
@@ -1768,7 +1582,7 @@ flow_send_recv(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nsd = nl_socket_alloc();
 	nl_connect(nsd, NETLINK_GENERIC);
 
-	msg = alloc_flow_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
+	msg = flow_nl_alloc_msg(cmd, pid, NLM_F_REQUEST|NLM_F_ACK, 0, family);
 	if (!msg) {
 		fprintf(stderr, "Error: Allocation failure\n");
 		return -ENOMSG;
@@ -1781,7 +1595,7 @@ flow_send_recv(int verbose, uint32_t pid, int family, uint32_t ifindex,
 	nl_send_auto(nsd, msg->nlbuf);
 	process_rx_message(verbose);
 
-	free_flow_msg(msg);
+	flow_nl_free_msg(msg);
 	return 0;
 }
 

