From: David Z. Dai <zdai@linux.vnet.ibm.com>
Date: Mon, 07 Oct 2019 12:12:42 -0500
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Use rtnl_lock to prevent
 race conditions between net and pci/pm
In-Reply-To: <CAKgT0Ue6+JJqcoFO1AcP8GCShmMPiUm1SNkbq9BxxWA-b5=Oow@mail.gmail.com>
References: <1570208647.1250.55.camel@oc5348122405>
 <20191004233052.28865.1609.stgit@localhost.localdomain>
 <1570241926.10511.7.camel@oc5348122405>
 <CAKgT0Ud7SupVd3RQmTEJ8e0fixiptS-1wFg+8V4EqpHEuAC3wQ@mail.gmail.com>
 <1570463459.1510.5.camel@oc5348122405>
 <CAKgT0Ue6+JJqcoFO1AcP8GCShmMPiUm1SNkbq9BxxWA-b5=Oow@mail.gmail.com>
Message-ID: <1570468362.1510.9.camel@oc5348122405>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-10-07 at 10:02 -0700, Alexander Duyck wrote:
> On Mon, Oct 7, 2019 at 8:51 AM David Z. Dai <zdai@linux.vnet.ibm.com> wrote:
> >
> 
> <snip>
> 
> > We have tested on one of the test box.
> > With this patch, it doesn't crash kernel anymore, which is good!
> >
> > However we see this warning message from the log file for irq number 0:
> > [10206.317270] Trying to free already-free IRQ 0
> >
> > With this stack:
> > [10206.317344] NIP [c00000000018cbf8] __free_irq+0x308/0x370
> > [10206.317346] LR [c00000000018cbf4] __free_irq+0x304/0x370
> > [10206.317347] Call Trace:
> > [10206.317348] [c00000008b92b970] [c00000000018cbf4] __free_irq
> > +0x304/0x370 (unreliable)
> > [10206.317351] [c00000008b92ba00] [c00000000018cd84] free_irq+0x84/0xf0
> > [10206.317358] [c00000008b92ba30] [d000000007449e60] e1000_free_irq
> > +0x98/0xc0 [e1000e]
> > [10206.317365] [c00000008b92ba60] [d000000007458a70] e1000e_pm_freeze
> > +0xb8/0x100 [e1000e]
> > [10206.317372] [c00000008b92baa0] [d000000007458b6c]
> > e1000_io_error_detected+0x34/0x70 [e1000e]
> > [10206.317375] [c00000008b92bad0] [c000000000040358] eeh_report_failure
> > +0xc8/0x190
> > [10206.317377] [c00000008b92bb20] [c00000000003eb2c] eeh_pe_dev_traverse
> > +0x9c/0x170
> > [10206.317379] [c00000008b92bbb0] [c000000000040d84]
> > eeh_handle_normal_event+0xe4/0x580
> > [10206.317382] [c00000008b92bc60] [c000000000041330] eeh_handle_event
> > +0x30/0x340
> > [10206.317384] [c00000008b92bd10] [c000000000041780] eeh_event_handler
> > +0x140/0x200
> > [10206.317386] [c00000008b92bdc0] [c0000000001397c8] kthread+0x1a8/0x1b0
> > [10206.317389] [c00000008b92be30] [c00000000000b560]
> > ret_from_kernel_thread+0x5c/0x7c
> >
> > Thanks! - David
> 
> Hmm. I wonder if it is possibly calling the report
> e1000_io_error_detected multiple times. If so then the secondary calls
> to e1000_pm_freeze would cause issues.
> 
> I will add a check so that we only down the interface and free the
> IRQs if the interface is in the present and running state.
> 
> I'll submit an update patch shortly.
> 
> Thanks.
> 
> - Alex
It only complains about IRQ number 0 in the log.
Could you please let me know the actual place where you will add the
check?
I can retest it again.

Thanks! - David

