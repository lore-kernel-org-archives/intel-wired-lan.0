From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Aug 2018 10:01:59 -0700
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <978998680.826474.1535469615050@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
 <1312873949.790150.1532681266921@mail.libero.it>
 <117857591.886490.1532956286262@mail.libero.it>
 <403709248.209641.1533555587417@mail.libero.it>
 <978998680.826474.1535469615050@mail.libero.it>
Message-ID: <CAKgT0Ueo7by0AuVocZiieZuv=ZhL9_FSP8R8yXndZwU1+eV-Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 28, 2018 at 8:20 AM Marco Berizzi <pupilla@libero.it> wrote:
>
> > Il 6 agosto 2018 alle 13.39 Marco Berizzi <pupilla@libero.it> ha scritto:
> >
> > > Il 30 luglio 2018 alle 15.11 Marco Berizzi <pupilla@libero.it> ha scritto:
> > >
> > > > Il 27 luglio 2018 alle 10.47 Marco Berizzi <pupilla@libero.it> ha scritto:
> > > >
> > > > Should I disable the TSO? Or should I set all my linux boxes MTU to 1500?
> > >
> > > Hello everyone,
> > >
> > > One hour ago I upgraded to linux 4.18-rc7 and I set the MTU=1500
> > >
> > > I will keep you updated.
> >
> > After 6 days uptime I got the same error message with MTU=1500.
> > Now I will upgrade to 4.18-rc8 with MTU=1500 and I will disable
> > the tso with the following command: ethtool -K eth0 tso off
>
> Hello everyone,
> same error also with tso disabled:
>
> [2226325.797978] igb 0000:08:00.0: Detected Tx Unit Hang
>                    Tx Queue             <1>
>                    TDH                  <cf>
>                    TDT                  <cf>
>                    next_to_use          <d0>
>                    next_to_clean        <cf>
>                  buffer_info[next_to_clean]
>                    time_stamp           <184aee600>
>                    next_to_watch        <000000003e213f5a>
>                    jiffies              <184aeea00>
>                    desc.status          <a8010>

Okay, so this looks like a Tx hang of some sort where writeback is not
being triggered.

What we may want do is turn up the level of information we are getting
out of the error. You can do that by running:
ethtool -s eth0 msglvl hw on tx_done on pktdata on

That should cause us to dump the Tx descriptor rings and packet data
when we encounter one of these hangs. It is possible we are looking at
some sort of error in the way the data is being formatted on the
descriptor ring that is resulting int he device stopping on whatever
descriptor is at offset <d0>.

Thanks.

- Alex
