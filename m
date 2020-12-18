From: Ben Greear <greearb@candelatech.com>
Date: Fri, 18 Dec 2020 10:08:18 -0800
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
Message-ID: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

One of our users reports that our 5.10 kernel negotiates the 1/2.5/5/10g NIC to 1Gbps
instead of 2.5Gbps.  Booting the 5.4 kernel shows 2.5Gbps as expected.

I have not yet tried to bisect this...is it a known issue?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
