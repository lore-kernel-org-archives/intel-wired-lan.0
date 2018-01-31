From: Ray Bellis <ray@isc.org>
Date: Wed, 31 Jan 2018 15:15:57 +0000
Subject: [Intel-wired-lan] X710 disable flow hashing?
Message-ID: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Is there a way to make an X710 card just deliver UDP packets to its
queues (12 in my case) round-robin without using flow hashing?

I'm using Fedora Core 23 with i40e driver version 1.3.9-k.

I know that's old, but I need to preserve this environment for long-term
benchmark comparisons.

thanks,

Ray
