From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Fri, 6 May 2016 16:26:24 +0000
Subject: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
In-Reply-To: <CAJ75kXY_PMK0iTyM5bbhQoAS9je5AqpW67jyZpJEUoNw0BPcqw@mail.gmail.com>
References: <CAJ75kXZV32hLzYY-dynYAj6NHm2xNoq89inmSSbqUyxPvUazEw@mail.gmail.com>
 <F6FB0E698C9B3143BDF729DF2228664691EA68EC@ORSMSX116.amr.corp.intel.com>
 <CAJ75kXY_PMK0iTyM5bbhQoAS9je5AqpW67jyZpJEUoNw0BPcqw@mail.gmail.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664691EA7CAF@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey William,

My validation hasn't be able to recreate the dereference on v4.1.x, v4.5.x or net_next.  Where exactly did you place the two line script in your rc scripts.  Our validation was able to run it as soon as ~14 second after the first boot message logged in dmesg.  Is this anywhere close to where you were executing it?  Likewise he has attempted running at both run level 3 and 5 in case that changed any of the times of how soon the rc scripts are executed.  So the more detail you can give of setup the more it might help us recreate what you are seeing.

Thanks,
-Don Skidmore <donald.c.skidmore>

 

> -----Original Message-----
> From: William Dauchy [mailto:wdauchy at gmail.com]
> Sent: Tuesday, May 03, 2016 5:33 AM
> To: Skidmore, Donald C <donald.c.skidmore@intel.com>
> Cc: NETDEV <netdev@vger.kernel.org>; intel-wired-lan at lists.osuosl.org;
> Alex Duyck <aduyck@mirantis.com>
> Subject: Re: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
> 
> Hello Don,
> 
> Thank you for your reply.
> 
> On Mon, May 2, 2016 at 11:33 PM, Skidmore, Donald C
> <donald.c.skidmore@intel.com> wrote:
> > Thanks for reporting the dereference.  Could you provide a little more
> detail on how you created this issue?  Are you just running the two
> commands (ip, sriov_numvfs) in some rc script and if you put a few second
> sleep in front of it you don't see the failure?
> 
> Your understanding is correct; a rc script is run with ip and echo in numvfs
> commands. I tried to reduce it to the minimum. If I put a sleep
> 20 in front of it, it does not crash. I also forgot to add I did not had the issue
> in 3.14.x with the same script.
> 
> Best,
> --
> William
