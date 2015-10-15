From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 16:32:56 +0000
Subject: [Intel-wired-lan] [next-queue 13/17] fm10k: Update adaptive ITR
 algorithm
In-Reply-To: <561F0C9F.6040900@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-13-git-send-email-jacob.e.keller@intel.com>
 <561EA08C.8090705@gmail.com> <1444853538.26286.42.camel@intel.com>
 <561ED9F1.5060104@gmail.com> <1444866649.26286.58.camel@intel.com>
 <561F0C9F.6040900@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB58577A79FB@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Wednesday, October 14, 2015 7:17 PM
> To: Keller, Jacob E; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next-queue 13/17] fm10k: Update adaptive
> ITR algorithm
> 
> >
> > So this is calculating the inverse ints/sec? where do we end up
> > converting this to microseconds. Hmm.
> 
> The value generated at the end is in microseconds.  Basically this would
> replace all the code that is located before your shift at the end that
> uses the PCIe factor + 8.  So everything from the size > 3000 check down
> to the adjustments for the other sizes.
> 
> I kind of always hated the algorithms that try to work everything out in
> terms of interrupts and then have to flip it over and into microseconds.
>   This is just working with the raw microseconds like the fm10k driver
> currently does.
> 

Ok, that makes sense. I figured that out a few minutes after sending the last email while I was on my way home. I'll try to code this up and see how it goes.

Regards,
Jake

