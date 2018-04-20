From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 20 Apr 2018 14:12:10 -0700
Subject: [Intel-wired-lan] [PATCH RFC net-next] igb: adjust SYSTIM
 register using TIMADJ register
In-Reply-To: <1524254196-21705-1-git-send-email-kshitiz.gupta@ni.com>
References: <1524254196-21705-1-git-send-email-kshitiz.gupta@ni.com>
Message-ID: <20180420211210.43oyqmqoho6gdnfh@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 20, 2018 at 02:56:36PM -0500, Kshitiz Gupta wrote:
> Currently the driver adjusts time by reading the current time and then
> modifying it before writing to SYSTIM register. This can introduce
> inaccuracies in SYSTIM. With a PREEMPT_RT kernel, spinlocks may be
> interrupted, which in the existing implementation may lead to increased
> time between the read and the write.
> 
> Alternatively as per section 7.8.3.2 in the i210 data sheet, this
> operation can be done more accurately by using the TIMADJ registers,
> but this should only be used for adjustments less than one 8th of the
> sync interval. Once this register is written, the software can poll on
> TSICR.TADJ to make sure that adjustment operation is completed.

I doubt the utility of this.  The first jump is typically to correct a
large offset of seconds, minutes, or even months.  After that, the
servo corrects any remaining error.

It would help if you would show us a clearly improved servo response
with this change applied.

Thanks,
Richard
