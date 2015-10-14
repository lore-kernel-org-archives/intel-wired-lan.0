From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 16:31:44 +0000
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <561E8176.8050803@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
 <561E7195.2010605@gmail.com> <1444838391.26286.11.camel@intel.com>
 <561E8176.8050803@gmail.com>
Message-ID: <1444840304.26286.13.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 09:23 -0700, Alexander Duyck wrote:
> The 36Gb/s number is pretty impressive and may be pushing you into
> other 
> limits.  What does the CPU utilization look like for your test?  Do
> you 
> see the thread handling the workload get fully utilized?  Also have
> you 
> tried enabling XPS to see if maybe you could squeeze a bit more out
> of 
> the core that is doing the test by improving locality?
> 
> - Alex

I don't have those offhand but I can go measure. I have already enabled
XPS in my setup with this test, though currently the default driver
doesn't enable it, so I do it manually. Without XPS, I get
significantly worse performance.

I will try to get CPU utilization numbers soon for this. And I'll also
try UDP_STREAM and TCP_STREAM both.

Regards,
Jake
