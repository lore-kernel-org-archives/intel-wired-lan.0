From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 7 May 2021 22:53:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e: small improvements
 on XDP path
In-Reply-To: <20210507221135.GB18159@ranger.igk.intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
 <CAJ8uoz3YSuPj6F+GHkk6yXHryUEOUhVSg2pDVEVrFA6b8Hgu6g@mail.gmail.com>
 <20210118103233.49bfd205@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210507221135.GB18159@ranger.igk.intel.com>
Message-ID: <c31e5d21868c2773897f88dfe97a2471b2ba7f35.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-05-08 at 00:11 +0200, Maciej Fijalkowski wrote:
> On Mon, Jan 18, 2021 at 10:32:33AM -0800, Jakub Kicinski wrote:
> > On Mon, 18 Jan 2021 08:31:23 +0100 Magnus Karlsson wrote:
> > > On Thu, Jan 14, 2021 at 3:34 PM Cristian Dumitrescu
> > > <cristian.dumitrescu@intel.com> wrote:
> > > > 
> > > > This patchset introduces some small and straightforward
> > > > improvements
> > > > to the Intel i40e driver XDP path. Each improvement is fully
> > > > described
> > > > in its associated patch.
> > > 
> > > Thank you for these clean ups Cristian!
> > > 
> > > For the series:
> > > 
> > > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > 
> > FWIW since this series is 100% driver code I'm expecting it will 
> > come downstream via Tony's tree. Please LMK if that's not the case.
> 
> I just realized that this set got somewhat abandonded. Tony, can you
> pick
> this? I wouldn't be surprised if it wouldn't apply cleanly anymore
> since
> it has been almost 4 months since the initial submission, but let's
> see...
> Otherwise we probably would have to ask Cristian to re-submit
> directly to
> IWL I guess.

If I'm not mistaken, these were sent and accepted in this request.

https://lore.kernel.org/netdev/20210209022323.2440775-1-anthony.l.nguyen at intel.com/

Thanks,
Tony
