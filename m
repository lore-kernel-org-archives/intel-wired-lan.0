From: Dan Streetman <dan.streetman@canonical.com>
Date: Thu, 28 Sep 2017 16:53:16 -0400
Subject: [Intel-wired-lan] i40e MDD events
Message-ID: <CAOZ2QJPbOrGLoZWnZUY268owFsFxFq-UcdYLbUn1Kf7tzE9oHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, I'm from Canonical support, and I have reports from an Ubuntu user
seeing MDD events occurring on a i40e nic, from the PF (not a VF)
while using the Ubuntu 4.4 kernel.  I found two commits that I thought
addressed this problem, but they did not help - the reporter still is
seeing MDD events, which reset the PF for every MDD event.  The
commits I thought fixed this, which have been added but still don't
fix the MDD events, are:

commit 3f3f7cb875c0f621485644d4fd7453b0d37f00e4
Author: Alexander Duyck <aduyck@mirantis.com>
Date:   Wed Mar 30 16:15:37 2016 -0700

    i40e/i40evf: Limit TSO to 7 descriptors for payload instead of 8 per packet


and then:

commit 841493a3f64395b60554afbcaa17f4350f90e764
Author: Alexander Duyck <alexander.h.duyck@intel.com>
Date:   Tue Sep 6 18:05:04 2016 -0700

    i40e: Limit TX descriptor count in cases where frag size is greater than 16K


The events are always of the form:
i40e 0000:0c:00.1: Malicious Driver Detection event 0x02 on TX queue
35 PF number 0x01 VF number 0x00

the queue and PF may vary, but it's always from the PF (never from VF)
and the event is always 2.

Unfortunately, the i40e spec doesn't really provide much helpful info
about what might specifically cause a MDD event, or what the event
codes mean (at least, not that I've found in the datasheet).  Does
anyone know what MDD event "2" means, does that indicate too many TX
descriptors, as was the issue for the above commits?  Or something
else?

Are there any other MDD-related commits that I missed since those 2
were added?  It's quite frustrating, because normally errors indicate
what the problem was, but the MDD errors have absolutely no indication
of what the NIC didn't like.

Thanks!
