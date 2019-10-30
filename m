From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 30 Oct 2019 13:21:35 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Add scatter gather support
In-Reply-To: <090fd6fa-bccd-ff67-8326-6eed7a9d5d56@molgen.mpg.de>
References: <20191030090848.20842-1-sasha.neftin@intel.com>
 <090fd6fa-bccd-ff67-8326-6eed7a9d5d56@molgen.mpg.de>
Message-ID: <57c07cd2-1a89-f20a-0fd2-2062415edf93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/30/2019 11:43, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> On 30.10.19 10:08, Sasha Neftin wrote:
>> Scatter gather is used to do DMA data transfers of data that is 
>> written to
>> noncontiguous areas of memory.
>> This patch enable scatter gather support.
> 
> enable*s*
> 
Thanks Paul - I will fix it and submit v2.
> Do you have numbers, if and how this improves performance?
> 
Yes, I've checked on two machines with i225 HW. For example, I've 
observed as follow at 2.5Gbps link speed:
sg	on 	off
tcp	2352.93	2342.19 slightly improved
udp	2403.97	2403.49 almost no impact
Generally, I see the TCP stream more affected.
But you could observe different behavior on different machines.
> How can this be tested?
> 
> [?]
I used netperf on my machines.
> 
> 
> Kind regards,
> 
> Paul

