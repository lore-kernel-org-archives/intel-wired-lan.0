From: Ben Greear <greearb@candelatech.com>
Date: Mon, 12 Aug 2019 14:14:33 -0700
Subject: [Intel-wired-lan] CMA alloc failed with 6 4-port X710 QAD4 NICs
Message-ID: <9e598973-0bca-eda1-c5df-9f3ef16bf700@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I have a user trying to boot up our 4.20+ kernel with 6 4-port 10G NICs in it.

dmesg is full of cma_alloc errors.  I increased CMA space to 32MB, but still no luck.

Any idea how much CMA memory is needed for this config?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

