From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Oct 2015 09:23:18 -0700
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <1444838391.26286.11.camel@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
 <561E7195.2010605@gmail.com> <1444838391.26286.11.camel@intel.com>
Message-ID: <561E8176.8050803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/14/2015 08:59 AM, Keller, Jacob E wrote:
> On Wed, 2015-10-14 at 08:15 -0700, Alexander Duyck wrote:
>> Even 40K might be a bit restrictive.  I've found that 10Gb NICs need
>> about 12K interrupts per second to avoid depleting the socket buffers
>> in
>> the case of a UDP test.  You might want to see if you see performance
>> gains by taking it up to 50K maybe even 60K.  As far as test cases to
>> use for tuning it would be useful to use a UDP_STREAM test instead of
>> TCP_STREAM since UDP is not bound by the link partner throughput.
>>
>> - Alex
> Thanks Alex. I tried with Tx set to 0usec up to 25, and for my tests
> with both TCP and UDP trials, I topped out at 25 and didn't see
> improvement beyond that. I think it's a reasonable default, but I
> likely have other areas on my system that need tuning first.
>
> I can give some more tests specifically with UDP again to see if any
> other changes made that not true.

The 36Gb/s number is pretty impressive and may be pushing you into other 
limits.  What does the CPU utilization look like for your test?  Do you 
see the thread handling the workload get fully utilized?  Also have you 
tried enabling XPS to see if maybe you could squeeze a bit more out of 
the core that is doing the test by improving locality?

- Alex
