From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 10 Aug 2020 17:42:08 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] igc: Fix SRRCTL register setup
In-Reply-To: <CAKgT0UdvyU+xkESA5HaqS2acbXQMJDUGdchRM2J6QExEcjiSkQ@mail.gmail.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
 <20200810210832.34699-3-andre.guedes@intel.com>
 <CAKgT0UdvyU+xkESA5HaqS2acbXQMJDUGdchRM2J6QExEcjiSkQ@mail.gmail.com>
Message-ID: <159710652891.38166.5470520112400402456@gwclark-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Alexander Duyck (2020-08-10 15:56:31)
> > @@ -1869,6 +1866,7 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
> >                  * because each write-back erases this info.
> >                  */
> >                 rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
> > +               rx_desc->read.hdr_addr = 0;
> >
> >                 rx_desc++;
> >                 bi++;
> 
> If you are going to do this it would be better to replace the line
> that is setting the length to zero instead of just adding this line.
> That way you can avoid having to rewrite it. I only had bothered with
> clearing the length field as it was a 32b field, however if you are
> wanting to flush the full 64b then I would recommend doing it there
> rather than here.

Just to make sure I'm on the same page, do you mean to move this line to
patch 2/3, right?
