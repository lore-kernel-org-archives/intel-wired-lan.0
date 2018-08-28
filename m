From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Tue, 28 Aug 2018 18:07:13 +0000
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
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C5F6B47@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Marco Berizzi
> Sent: Tuesday, August 28, 2018 8:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
> 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
> 
> > Il 6 agosto 2018 alle 13.39 Marco Berizzi <pupilla@libero.it> ha scritto:
> >
> > > Il 30 luglio 2018 alle 15.11 Marco Berizzi <pupilla@libero.it> ha scritto:
> > >
> > > > Il 27 luglio 2018 alle 10.47 Marco Berizzi <pupilla@libero.it> ha scritto:
> > > >
> > > > Should I disable the TSO? Or should I set all my linux boxes MTU to
> 1500?
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

Thanks for the update.  We'll take a look into it.  

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


