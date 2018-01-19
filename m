From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Sat, 20 Jan 2018 07:55:00 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
 <20180119085952.u63kius4ud34lleq@f1.synalogic.ca>
 <20180119133648.s5nbm4gvby6c33av@f1.synalogic.ca>
 <CAKgT0Ue6HRZYq+jkmZjGgvZZD4-C1yb_y+xDhcxbYVBANDjMBg@mail.gmail.com>
 <20180119224517.klugizz5n5zznryx@f1.synalogic.ca>
Message-ID: <20180119225500.lq2vpnjh5isxiovf@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/20 07:45, Benjamin Poirier wrote:
[...]
> > 
> > I'm of the mind that we need to cut down on the code thrash.  This
> > driver is supposed to have been in a "maintenance" mode for the last
> > year or so as there aren't being any new parts added is my
> > understanding. As-is I don't see any reason why 16ecba59bc33 ("e1000e:
> > Do not read ICR in Other interrupt", v4.5-rc1) was submitted or
> > accepted in the first place. I don't see any notes about it fixing any
> > bug or addressing any issue and it seems like that is the start of all
> > the issues we have been having recently with RXO triggering more
> > interrupts, various link issues, and this most recent VMware issue.
> 
> I'm sorry to say but you're the one who suggested that change:
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1510.3/03528.html
> 
> On 2015/10/28 23:08, Alexander Duyck wrote:
> > On 10/22/2015 05:32 PM, Benjamin Poirier wrote:
> [...]
> > 
> > I would argue your first patch probably didn't go far enough to remove dead
> > code.  Specifically you should only ever get into this function if LSC is
> > set.  There are no other causes that should trigger this.  As such you could
> > probably remove the ICR read, and instead replace it with an ICR write of
> > the LSC bit since OTHER is already cleared via EIAC.
> > 

... The assumption that "There are no other causes that should trigger
this." turned out to be wrong and that caused the RXO problems. Clearing
OTHER via EIAC is causing the problems with vmware now. I don't think
you foresaw those problems back in 2015 and neither did I.
