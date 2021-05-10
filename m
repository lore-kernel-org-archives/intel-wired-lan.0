From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 10 May 2021 10:57:28 +0200
Subject: [Intel-wired-lan] [PATCH intel-net 0/5] i40e: ice: ixgbe:
 ixgbevf: igb: add correct exception tracing for XDP
In-Reply-To: <CAJ8uoz0Pgfn8kai34_MFGYv3m7c24bpo4DhjZ8oLgd4zaGMWsg@mail.gmail.com>
References: <20210423100446.15412-1-magnus.karlsson@gmail.com>
 <75d0a1d13a755bc128458c0d43f16d54fe08051e.camel@intel.com>
 <CAJ8uoz0Pgfn8kai34_MFGYv3m7c24bpo4DhjZ8oLgd4zaGMWsg@mail.gmail.com>
Message-ID: <20210510105728.2eac4666@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 10 May 2021 08:06:00 +0200
Magnus Karlsson <magnus.karlsson@gmail.com> wrote:

> On Sat, May 8, 2021 at 12:58 AM Nguyen, Anthony L
> <anthony.l.nguyen@intel.com> wrote:
> >
> > On Fri, 2021-04-23 at 12:04 +0200, Magnus Karlsson wrote:  
> > > Add missing exception tracing to XDP when a number of different errors
> > > can occur. The support was only partial. Several errors where not
> > > logged which would confuse the user quite a lot not knowing where and
> > > why the packets disappeared.
> > >
> > > This patch set fixes this for all Intel drivers with XDP support.
> > >
> > > Thanks: Magnus  
> >
> > This doesn't apply anymore with the 5.13 patches. It looks like your
> > "optimize for XDP_REDIRECT in xsk path" patches are conflicting with
> > some of these. Did you want to rework them?  
> 
> I will rebase them and resubmit.

Thanks for working on this Magnus, highly appreciated.  This should
help end-users troubleshoot these kind of 'exception' packet drops.

We have people that will look at updating the sample/bpf/ programs
(that does XDP redirect) to report on these exception errors/drops.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

