From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 22 Oct 2020 11:04:55 -0700
Subject: [Intel-wired-lan] [PATCH 7/9] igc: Add support for XDP_TX action
In-Reply-To: <20201022101003.GC61349@ranger.igk.intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
 <20201009025349.4037-8-andre.guedes@intel.com>
 <20201021145742.GC58344@ranger.igk.intel.com>
 <160331862448.64680.18381150586195546148@lsachorn-mobl.amr.corp.intel.com>
 <20201022101003.GC61349@ranger.igk.intel.com>
Message-ID: <160338989511.80318.17251246598552128793@skottana-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Quoting Maciej Fijalkowski (2020-10-22 03:10:03)
> > > > +
> > > > +     buffer->next_to_watch = desc;
> > > > +
> > > > +     ring->next_to_use = (ring->next_to_use + 1) % ring->count;
> > > 
> > > Please avoid modulos.
> > 
> > Sure, I'll do it. Just out of curiosity, why modulo operation should be
> > avoided?
> 
> Just because it's slow and you're in fast path :p but you can take it as a
> suggestion.

Thanks, it makes sense. Also, looking at other Intel drivers, they handle
wrapping with an if-clause. I'll do the same here.

Cheers,
Andre
