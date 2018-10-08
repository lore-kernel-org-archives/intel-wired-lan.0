From: Ray Bellis <ray@isc.org>
Date: Mon, 8 Oct 2018 10:29:46 +0200
Subject: [Intel-wired-lan] "ethq" - NIC queue monitoring app
Message-ID: <22ce3acd-2eb1-7e6a-875b-c9b51294c6ec@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I've recently developed and published "ethq", which generates a
"top"-like view of the traffic on each individual NIC queue.

Because there's no convention for the statistic strings (ETH_SS_STATS)
used by each NIC driver it's necessary to generate pattern matching code
to add driver support.  In the context of this list, there's already
support for the i40, igb and ixgbe drivers.

The source is at https://github.com/isc-projects/ethq.git

Ray Bellis
ISC Research Fellow

