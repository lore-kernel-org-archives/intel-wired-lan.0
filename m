From: Josh Hunt <johunt@akamai.com>
Date: Tue, 22 Sep 2015 11:01:04 -0500
Subject: [Intel-wired-lan] e1000e tx queue timeout with small mss values
Message-ID: <56017B40.90308@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We are seeing transmit queue timeouts with the 82574L even with the 
following patch applied, e1000e: DoS while TSO enabled caused by link 
partner with small MSS, commit d821a4c4d11ad160925dab2bb009b8444beff484 
upstream. We're running upstream 3.14.43. We've noticed an increase in 
the frequency of hitting the timeouts when we have tcp mtu probing 
enabled. This is allowing some connections to get MSS values of 36.

There was some discussion during the original reporting of this issue on 
trying to reproduce it in a lab setting, possibly setting the advmss via 
ip route. I've tried this in our lab, but am unable to trigger the 
problem. I was wondering if anyone there knows how to possibly trigger 
this issue in a lab setting?

Thanks for any help you can provide.

Josh
