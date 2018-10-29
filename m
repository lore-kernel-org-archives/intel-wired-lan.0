From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Mon, 29 Oct 2018 13:52:09 +0100
Subject: [Intel-wired-lan] [RFC PATCH 1/4] ptp: add
 PTP_SYS_OFFSET_EXTENDED ioctl
In-Reply-To: <87in1o73qo.fsf@intel.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-2-mlichvar@redhat.com>
 <87in1o73qo.fsf@intel.com>
Message-ID: <20181029125209.GC31668@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 26, 2018 at 03:16:47PM -0700, Vinicius Costa Gomes wrote:
> > +	case PTP_SYS_OFFSET_EXTENDED:
> > +		if (!ptp->info->gettimex64) {
> > +			err = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		sysoff_extended = memdup_user((void __user *)arg,
> > +					      sizeof(*sysoff_extended));
> 
> Looks like you forgot to free 'sysoff_extended', no? 

Oh, I did. Thanks for catching that. I'll fix it in the next version.

-- 
Miroslav Lichvar
