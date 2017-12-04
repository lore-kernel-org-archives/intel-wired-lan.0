From: Joe Buehler <aspam@cox.net>
Date: Mon, 04 Dec 2017 16:41:15 -0500
Subject: [Intel-wired-lan] ixgbevf RX latency outliers
Message-ID: <5A25C0FB.10006@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I am using the ixgbevf driver shipped with the 4.4.86 LINUX
realtime-patched kernel in a VM using SRIOV.

The kernel is timestamping incoming frames and in general is doing a
great job but I am having some difficulties with RX latency outliers.

Presumably something is not servicing the NIC in a timely fashion, or
the NIC is holding on to frames too long.  I am looking for some info on
the design of the driver, the intent being perhaps to change NIC config,
revise RT priorities and/or thread affinities.

There appear to be 3 IRQ threads for example -- what are they for?

Any help much appreciated.

Joe
