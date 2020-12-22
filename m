From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 22 Dec 2020 09:12:55 -0800
Subject: [Intel-wired-lan] Fw: [Bug 210855] New: Increased latency & jitter
 with e1000e on Linux 5.8
Message-ID: <20201222091255.55fe72c3@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Begin forwarded message:

Date: Tue, 22 Dec 2020 16:59:27 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 210855] New: Increased latency & jitter with e1000e on Linux 5.8


https://bugzilla.kernel.org/show_bug.cgi?id=210855

            Bug ID: 210855
           Summary: Increased latency & jitter with e1000e on Linux 5.8
           Product: Networking
           Version: 2.5
    Kernel Version: 5.8
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen at networkplumber.org
          Reporter: tm at del.bg
        Regression: No

I have a Linux router with the following specs:

Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz

01:00.0  Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
01:00.1  Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
02:00.0  Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
02:00.1  Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
03:00.0  Intel Corporation Ethernet Controller 10G X550T (rev 01)
03:00.1  Intel Corporation Ethernet Controller 10G X550T (rev 01)
04:00.0  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
04:00.1  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)

Up to Linux 5.7 kernel everything was ok. After upgrading to 5.8 I've noticed
that latency and jitter to one of the e1000e NICs (82571EB) increased.

Further tests revealed the following:

# 4.19  rtt min/avg/max/mdev = 0.183/0.275/0.382/0.032 ms
# 5.0   rtt min/avg/max/mdev = 0.180/0.249/0.310/0.034 ms
# 5.4   rtt min/avg/max/mdev = 0.146/0.226/0.306/0.046 ms
# 5.6   rtt min/avg/max/mdev = 0.128/0.172/0.210/0.022 ms
# 5.7   rtt min/avg/max/mdev = 0.147/0.181/0.233/0.024 ms

# 5.8   rtt min/avg/max/mdev = 0.152/2.182/3.944/1.524 ms
# 5.9   rtt min/avg/max/mdev = 0.345/2.095/4.192/1.160 ms
# 5.10  rtt min/avg/max/mdev = 0.345/2.095/4.192/1.160 ms

Single ping session looks like this:

PING 172.31.252.132 (172.31.252.132) 56(84) bytes of data.
64 bytes from 172.31.252.132: icmp_seq=1 ttl=64 time=2.42 ms
64 bytes from 172.31.252.132: icmp_seq=2 ttl=64 time=0.872 ms
64 bytes from 172.31.252.132: icmp_seq=3 ttl=64 time=0.171 ms
64 bytes from 172.31.252.132: icmp_seq=4 ttl=64 time=1.89 ms
64 bytes from 172.31.252.132: icmp_seq=5 ttl=64 time=0.163 ms
64 bytes from 172.31.252.132: icmp_seq=6 ttl=64 time=0.196 ms
64 bytes from 172.31.252.132: icmp_seq=7 ttl=64 time=0.191 ms
64 bytes from 172.31.252.132: icmp_seq=8 ttl=64 time=1.90 ms
64 bytes from 172.31.252.132: icmp_seq=9 ttl=64 time=4.00 ms

No such problem on another NIC (10G X550T).

Using e1000e-3.8.7.tar.gz driver (dkms) didn't help at all.

I'm trying to bisect it right now...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
