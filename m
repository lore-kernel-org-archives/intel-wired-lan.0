From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 12 Aug 2019 21:38:13 +0000
Subject: [Intel-wired-lan] CMA alloc failed with 6 4-port X710 QAD4 NICs
In-Reply-To: <9e598973-0bca-eda1-c5df-9f3ef16bf700@candelatech.com>
References: <9e598973-0bca-eda1-c5df-9f3ef16bf700@candelatech.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AFF99F3@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We probably need a lot of continguous memory. Offhand, I don't know, but with >1500 queue pairs, we need a lot of memory in general.

I don't think we've had any more than 8 NICs in a system, and when I asked some people how many NICs we can use they gave me a more practical answer: 1 less than the config that makes the system unusable.

I don' t think there is a catch-all answer, so the questions we'd have are:
1) how much memory do you have
2) how many cards do you have in the system
3) how many option roms are in the cards in the system
4) you're not running a 32-bit OS, are you?

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Ben Greear
Sent: Monday, August 12, 2019 2:15 PM
To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] CMA alloc failed with 6 4-port X710 QAD4 NICs

Hello,

I have a user trying to boot up our 4.20+ kernel with 6 4-port 10G NICs in it.

dmesg is full of cma_alloc errors.  I increased CMA space to 32MB, but still no luck.

Any idea how much CMA memory is needed for this config?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
