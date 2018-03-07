From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:12 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
Message-ID: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series is the v3 of the Time based packet transmission RFC, which was
originally proposed by Richard Cochran (v1: https://lwn.net/Articles/733962/ )
and further developed by us with the addition of the tbs qdisc
(v2: https://lwn.net/Articles/744797/ ).

It introduces a new socket option (SO_TXTIME), a new qdisc (tbs) and
implements support for hw offloading on the igb driver for the Intel
i210 NIC. The tbs qdisc also supports SW best effort that can be used
as a fallback.

The main changes since v2 can be found below.

Fixes since v2:
 - skb->tstamp is only cleared on the forwarding path;
 - ktime_t is no longer the type used for timestamps (s64 is);
 - get_unaligned() is now used for copying data from the cmsg header;
 - added getsockopt() support for SO_TXTIME;
 - restricted SO_TXTIME input range to [0,1];
 - removed ns_capable() check from __sock_cmsg_send();
 - the qdisc  control struct now uses a 32 bitmap for config flags;
 - fixed qdisc backlog decrement bug;
 - 'overlimits' is now incremented on dequeue() drops in addition to the
   'dropped' counter;

Interface changes since v2:
 * CMSG interface:
   - added a per-packet clockid parameter to the cmsg (SCM_CLOCKID);
   - added a per-packet drop_if_late flag to the cmsg (SCM_DROP_IF_LATE);
 * tc-tbs:
   - clockid now receives a string;
     e.g.: CLOCK_REALTIME or /dev/ptp0
   - offload is now a standalone argument (i.e. no more offload 1);
   - sorting is now argument that enables txtime based sorting provided
     by the qdisc;

Design changes since v2:
 - Now on the dequeue() path, tbs only drops an expired packet if it has the
   skb->tc_drop_if_late flag set. In practical terms, this will define if
   the semantics of txtime on a system is "not earlier than" or "not later
   than" a given timestamp;
 - Now on the enqueue() path, the qdisc will drop a packet if its clockid
   doesn't match the qdisc's one;
 - Sorting the packets based on their txtime is now an option for the disc.
   Effectively, this means it can be configured in 4 modes: HW offload or
   SW best-effort, sorting enabled or disabled;


The tbs qdisc is designed so it buffers packets until a configurable time before
their deadline (tx times). If sorting is enabled, regardless of HW offload or SW
fallback modes, the qdisc uses a rbtree internally so the buffered packets are
always 'ordered' by the earliest deadline.

If sorting is disabled, then for HW offload the qdisc will use a 'raw' FIFO
through qdisc_enqueue_tail() / qdisc_dequeue_head(), whereas for SW best-effort,
it will use a 'scheduled' FIFO.

The other configurable parameter from the tbs qdisc is the clockid to be used.
In order to provide that, this series adds a new API to pkt_sched.h (i.e.
qdisc_watchdog_init_clockid()).

The tbs qdisc will drop any packets with a transmission time in the past or
when a deadline is missed if SCM_DROP_IF_LATE is set. Queueing packets in
advance plus configuring the delta parameter for the system correctly makes
all the difference in reducing the number of drops. Moreover, note that the
delta parameter ends up defining the Tx time when SW best-effort is used
given that the timestamps won't be used by the NIC on this case.

Examples:

# SW best-effort with sorting #

    $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
               map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

    $ tc qdisc add dev enp2s0 parent 100:1 tbs delta 100000 \
               clockid CLOCK_REALTIME sorting

    In this example first the mqprio qdisc is setup, then the tbs qdisc is
    configured onto the first hw Tx queue using SW best-effort with sorting
    enabled. Also, it is configured so the timestamps on each packet are in
    reference to the clockid CLOCK_REALTIME and so packets are dequeued from
    the qdisc 100000 nanoseconds before their transmission time.


# HW offload without sorting #

    $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
               map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

    $ tc qdisc add dev enp2s0 parent 100:1 tbs offload

    In this example, the Qdisc will use HW offload for the control of the
    transmission time through the network adapter. It's assumed implicitly
    the timestamp in skbuffs are in reference to the interface's PHC and
    setting any other valid clockid would be treated as an error. Because
    there is no scheduling being performed in the qdisc, setting a delta != 0
    would also be considered an error.


# HW offload with sorting #
    $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
               map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

    $ tc qdisc add dev enp2s0 parent 100:1 tbs offload delta 100000 \
               clockid CLOCK_REALTIME sorting

    Here, the Qdisc will use HW offload for the txtime control again,
    but now sorting will be enabled, and thus there will be scheduling being
    performed by the qdisc. That is done based on the clockid CLOCK_REALTIME
    and packets leave the Qdisc "delta" (100000) nanoseconds before
    their transmission time. Because this will be using HW offload and
    since dynamic clocks are not supported by the hrtimer, the system clock
    and the PHC clock must be synchronized for this mode to behave as expected.


For testing, we've followed a similar approach from the v1 and v2 testing and
no significant changes on the results were observed. An updated version of
udp_tai.c is attached to this cover letter.

For last, most of the To Dos we still have before a final patchset are related
to further testing the igb support:
 - testing with L2 only talkers + AF_PACKET sockets;
 - testing tbs in conjunction with cbs;

Thanks for all the feedback so far,
Jesus


Jesus Sanchez-Palencia (12):
  sock: Fix SO_ZEROCOPY switch case
  net: Clear skb->tstamp only on the forwarding path
  posix-timers: Add CLOCKID_INVALID mask
  net: SO_TXTIME: Add clockid and drop_if_late params
  net: ipv4: raw: Handle remaining txtime parameters
  net: ipv4: udp: Handle remaining txtime parameters
  net: packet: Handle remaining txtime parameters
  net/sched: Add HW offloading capability to TBS
  igb: Refactor igb_configure_cbs()
  igb: Only change Tx arbitration when CBS is on
  igb: Refactor igb_offload_cbs()
  igb: Add support for TBS offload

Richard Cochran (4):
  net: Add a new socket option for a future transmit time.
  net: ipv4: raw: Hook into time based transmission.
  net: ipv4: udp: Hook into time based transmission.
  net: packet: Hook into time based transmission.

Vinicius Costa Gomes (2):
  net/sched: Allow creating a Qdisc watchdog with other clocks
  net/sched: Introduce the TBS Qdisc

 arch/alpha/include/uapi/asm/socket.h           |   5 +
 arch/frv/include/uapi/asm/socket.h             |   5 +
 arch/ia64/include/uapi/asm/socket.h            |   5 +
 arch/m32r/include/uapi/asm/socket.h            |   5 +
 arch/mips/include/uapi/asm/socket.h            |   5 +
 arch/mn10300/include/uapi/asm/socket.h         |   5 +
 arch/parisc/include/uapi/asm/socket.h          |   5 +
 arch/s390/include/uapi/asm/socket.h            |   5 +
 arch/sparc/include/uapi/asm/socket.h           |   5 +
 arch/xtensa/include/uapi/asm/socket.h          |   5 +
 drivers/net/ethernet/intel/igb/e1000_defines.h |  16 +
 drivers/net/ethernet/intel/igb/igb.h           |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c      | 239 +++++++---
 include/linux/netdevice.h                      |   2 +
 include/linux/posix-timers.h                   |   1 +
 include/linux/skbuff.h                         |   3 +
 include/net/pkt_sched.h                        |   7 +
 include/net/sock.h                             |   4 +
 include/uapi/asm-generic/socket.h              |   5 +
 include/uapi/linux/pkt_sched.h                 |  18 +
 net/core/skbuff.c                              |   1 -
 net/core/sock.c                                |  44 +-
 net/ipv4/raw.c                                 |   7 +
 net/ipv4/udp.c                                 |  10 +-
 net/packet/af_packet.c                         |  19 +
 net/sched/Kconfig                              |  11 +
 net/sched/Makefile                             |   1 +
 net/sched/sch_api.c                            |  11 +-
 net/sched/sch_tbs.c                            | 591 +++++++++++++++++++++++++
 29 files changed, 978 insertions(+), 63 deletions(-)
 create mode 100644 net/sched/sch_tbs.c

-- 
2.16.2

---8<---
/*
 * This program demonstrates transmission of UDP packets using the
 * system TAI timer.
 *
 * Copyright (C) 2017 linutronix GmbH
 *
 * Large portions taken from the linuxptp stack.
 * Copyright (C) 2011, 2012 Richard Cochran <richardcochran@gmail.com>
 *
 * Some portions taken from the sgd test program.
 * Copyright (C) 2015 linutronix GmbH
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */
#define _GNU_SOURCE /*for CPU_SET*/
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <ifaddrs.h>
#include <linux/ethtool.h>
#include <linux/net_tstamp.h>
#include <linux/sockios.h>
#include <net/if.h>
#include <netinet/in.h>
#include <poll.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define DEFAULT_PERIOD	1000000
#define DEFAULT_DELAY	500000
#define MCAST_IPADDR	"239.1.1.1"
#define UDP_PORT	7788

#ifndef SO_TXTIME
#define SO_TXTIME	61
#define SCM_TXTIME	SO_TXTIME
#define SCM_DROP_IF_LATE	62
#define SCM_CLOCKID	63
#endif

#define pr_err(s)	fprintf(stderr, s "\n")
#define pr_info(s)	fprintf(stdout, s "\n")

static int running = 1, use_so_txtime = 1;
static int period_nsec = DEFAULT_PERIOD;
static int waketx_delay = DEFAULT_DELAY;
static struct in_addr mcast_addr;

static int mcast_bind(int fd, int index)
{
	int err;
	struct ip_mreqn req;
	memset(&req, 0, sizeof(req));
	req.imr_ifindex = index;
	err = setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF, &req, sizeof(req));
	if (err) {
		pr_err("setsockopt IP_MULTICAST_IF failed: %m");
		return -1;
	}
	return 0;
}

static int mcast_join(int fd, int index, const struct sockaddr *grp,
		      socklen_t grplen)
{
	int err, off = 0;
	struct ip_mreqn req;
	struct sockaddr_in *sa = (struct sockaddr_in *) grp;

	memset(&req, 0, sizeof(req));
	memcpy(&req.imr_multiaddr, &sa->sin_addr, sizeof(struct in_addr));
	req.imr_ifindex = index;
	err = setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &req, sizeof(req));
	if (err) {
		pr_err("setsockopt IP_ADD_MEMBERSHIP failed: %m");
		return -1;
	}
	err = setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP, &off, sizeof(off));
	if (err) {
		pr_err("setsockopt IP_MULTICAST_LOOP failed: %m");
		return -1;
	}
	return 0;
}

static void normalize(struct timespec *ts)
{
	while (ts->tv_nsec > 999999999) {
		ts->tv_sec += 1;
		ts->tv_nsec -= 1000000000;
	}
}

static int sk_interface_index(int fd, const char *name)
{
	struct ifreq ifreq;
	int err;

	memset(&ifreq, 0, sizeof(ifreq));
	strncpy(ifreq.ifr_name, name, sizeof(ifreq.ifr_name) - 1);
	err = ioctl(fd, SIOCGIFINDEX, &ifreq);
	if (err < 0) {
		pr_err("ioctl SIOCGIFINDEX failed: %m");
		return err;
	}
	return ifreq.ifr_ifindex;
}

static int open_socket(const char *name, struct in_addr mc_addr, short port)
{
	struct sockaddr_in addr;
	int fd, index, on = 1;
	int priority = 3;

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons(port);

	fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (fd < 0) {
		pr_err("socket failed: %m");
		goto no_socket;
	}
	index = sk_interface_index(fd, name);
	if (index < 0)
		goto no_option;

	if (setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &priority, sizeof(priority))) {
		pr_err("Couldn't set priority");
		goto no_option;
	}
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
		pr_err("setsockopt SO_REUSEADDR failed: %m");
		goto no_option;
	}
	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr))) {
		pr_err("bind failed: %m");
		goto no_option;
	}
	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))) {
		pr_err("setsockopt SO_BINDTODEVICE failed: %m");
		goto no_option;
	}
	addr.sin_addr = mc_addr;
	if (mcast_join(fd, index, (struct sockaddr *) &addr, sizeof(addr))) {
		pr_err("mcast_join failed");
		goto no_option;
	}
	if (mcast_bind(fd, index)) {
		goto no_option;
	}
	if (use_so_txtime && setsockopt(fd, SOL_SOCKET, SO_TXTIME, &on, sizeof(on))) {
		pr_err("setsockopt SO_TXTIME failed: %m");
		goto no_option;
	}

	return fd;
no_option:
	close(fd);
no_socket:
	return -1;
}

static int udp_open(const char *name)
{
	int fd;

	if (!inet_aton(MCAST_IPADDR, &mcast_addr))
		return -1;

	fd = open_socket(name, mcast_addr, UDP_PORT);

	return fd;
}

static int udp_send(int fd, void *buf, int len, __u64 txtime, clockid_t clkid)
{
	char control[CMSG_SPACE(sizeof(txtime)) + CMSG_SPACE(sizeof(clkid)) + CMSG_SPACE(sizeof(uint8_t))] = {};
	struct sockaddr_in sin;
	struct cmsghdr *cmsg;
	struct msghdr msg;
	struct iovec iov;
	ssize_t cnt;
	uint8_t drop_if_late = 1;

	memset(&sin, 0, sizeof(sin));
	sin.sin_family = AF_INET;
	sin.sin_addr = mcast_addr;
	sin.sin_port = htons(UDP_PORT);

	iov.iov_base = buf;
	iov.iov_len = len;

	memset(&msg, 0, sizeof(msg));
	msg.msg_name = &sin;
	msg.msg_namelen = sizeof(sin);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	/*
	 * We specify the transmission time in the CMSG.
	 */
	if (use_so_txtime) {
		msg.msg_control = control;
		msg.msg_controllen = sizeof(control);

		cmsg = CMSG_FIRSTHDR(&msg);
		cmsg->cmsg_level = SOL_SOCKET;
		cmsg->cmsg_type = SCM_TXTIME;
		cmsg->cmsg_len = CMSG_LEN(sizeof(__u64));
		*((__u64 *) CMSG_DATA(cmsg)) = txtime;

		cmsg = CMSG_NXTHDR(&msg, cmsg);
		cmsg->cmsg_level = SOL_SOCKET;
		cmsg->cmsg_type = SCM_CLOCKID;
		cmsg->cmsg_len = CMSG_LEN(sizeof(clockid_t));
		*((clockid_t *) CMSG_DATA(cmsg)) = clkid;

		cmsg = CMSG_NXTHDR(&msg, cmsg);
		cmsg->cmsg_level = SOL_SOCKET;
		cmsg->cmsg_type = SCM_DROP_IF_LATE;
		cmsg->cmsg_len = CMSG_LEN(sizeof(uint8_t));
		*((uint8_t *) CMSG_DATA(cmsg)) = drop_if_late;
	}
	cnt = sendmsg(fd, &msg, 0);
	if (cnt < 1) {
		pr_err("sendmsg failed: %m");
		return cnt;
	}
	return cnt;
}

static unsigned char tx_buffer[256];
static int marker;

static int run_nanosleep(clockid_t clkid, int fd)
{
	struct timespec ts;
	int cnt, err;
	__u64 txtime;

	clock_gettime(clkid, &ts);

	/* Start one to two seconds in the future. */
	ts.tv_sec += 1;
	ts.tv_nsec = 1000000000 - waketx_delay;
	normalize(&ts);

	txtime = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
	txtime += waketx_delay;

	while (running) {
		err = clock_nanosleep(clkid, TIMER_ABSTIME, &ts, NULL);
		switch (err) {
		case 0:
			cnt = udp_send(fd, tx_buffer, sizeof(tx_buffer), txtime, clkid);
			if (cnt != sizeof(tx_buffer)) {
				pr_err("udp_send failed");
			}
			memset(tx_buffer, marker++, sizeof(tx_buffer));
			ts.tv_nsec += period_nsec;
			normalize(&ts);
			txtime += period_nsec;
			break;
		case EINTR:
			continue;
		default:
			fprintf(stderr, "clock_nanosleep returned %d: %s",
				err, strerror(err));
			return err;
		}
	}

	return 0;
}

static int set_realtime(pthread_t thread, int priority, int cpu)
{
	cpu_set_t cpuset;
	struct sched_param sp;
	int err, policy;

	int min = sched_get_priority_min(SCHED_FIFO);
	int max = sched_get_priority_max(SCHED_FIFO);

	fprintf(stderr, "min %d max %d\n", min, max);

	if (priority < 0) {
		return 0;
	}

	err = pthread_getschedparam(thread, &policy, &sp);
	if (err) {
		fprintf(stderr, "pthread_getschedparam: %s\n", strerror(err));
		return -1;
	}

	sp.sched_priority = priority;

	err = pthread_setschedparam(thread, SCHED_FIFO, &sp);
	if (err) {
		fprintf(stderr, "pthread_setschedparam: %s\n", strerror(err));
		return -1;
	}

	if (cpu < 0) {
		return 0;
	}
	CPU_ZERO(&cpuset);
	CPU_SET(cpu, &cpuset);
	err = pthread_setaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
	if (err) {
		fprintf(stderr, "pthread_setaffinity_np: %s\n", strerror(err));
		return -1;
	}

	return 0;
}

static void usage(char *progname)
{
	fprintf(stderr,
		"\n"
		"usage: %s [options]\n"
		"\n"
		" -c [num]   run on CPU 'num'\n"
		" -d [num]   delay from wake up to transmission in nanoseconds (default %d)\n"
		" -h         prints this message and exits\n"
		" -i [name]  use network interface 'name'\n"
		" -p [num]   run with RT priorty 'num'\n"
		" -P [num]   period in nanoseconds (default %d)\n"
		" -u         do not use SO_TXTIME\n"
		"\n",
		progname, DEFAULT_DELAY, DEFAULT_PERIOD);
}

int main(int argc, char *argv[])
{
	int c, cpu = -1, err, fd, priority = -1;
	clockid_t clkid = CLOCK_REALTIME;
	char *iface = NULL, *progname;

	/* Process the command line arguments. */
	progname = strrchr(argv[0], '/');
	progname = progname ? 1 + progname : argv[0];
	while (EOF != (c = getopt(argc, argv, "c:d:hi:p:P:u"))) {
		switch (c) {
		case 'c':
			cpu = atoi(optarg);
			break;
		case 'd':
			waketx_delay = atoi(optarg);
			break;
		case 'h':
			usage(progname);
			return 0;
		case 'i':
			iface = optarg;
			break;
		case 'p':
			priority = atoi(optarg);
			break;
		case 'P':
			period_nsec = atoi(optarg);
			break;
		case 'u':
			use_so_txtime = 0;
			break;
		case '?':
			usage(progname);
			return -1;
		}
	}

	if (waketx_delay > 999999999 || waketx_delay < 0) {
		pr_err("Bad wake up to transmission delay.");
		usage(progname);
		return -1;
	}

	if (period_nsec < 1000) {
		pr_err("Bad period.");
		usage(progname);
		return -1;
	}

	if (!iface) {
		pr_err("Need a network interface.");
		usage(progname);
		return -1;
	}

	if (set_realtime(pthread_self(), priority, cpu)) {
		return -1;
	}

	fd = udp_open(iface);
	if (fd < 0) {
		return -1;
	}

	err = run_nanosleep(clkid, fd);

	close(fd);
	return err;
}

