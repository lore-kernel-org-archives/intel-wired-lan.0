From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Tue, 31 Jul 2018 15:53:15 +0000
Subject: [Intel-wired-lan] Issue with driver i40e stat strings count
 mismatch
In-Reply-To: <20180731162835.628ebb62@redhat.com>
References: <20180710131721.657e55a5@redhat.com>
 <64be8e6a-c285-2864-fd91-356eba645acd@kpanic.de>
 <20180731162835.628ebb62@redhat.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C5C1128@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesper Dangaard Brouer
> Sent: Tuesday, July 31, 2018 7:29 AM
> To: Stefan Assmann <sassmann@kpanic.de>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>; brouer at redhat.com; Topel, Bjorn
> <bjorn.topel@intel.com>
> Subject: Re: [Intel-wired-lan] Issue with driver i40e stat strings count
> mismatch
> 
> 
> On Tue, 31 Jul 2018 09:05:40 +0200 Stefan Assmann
> <sassmann@kpanic.de> wrote:
> 
> > From: Stefan Assmann <sassmann@kpanic.de>
> > To: Jesper Dangaard Brouer <brouer@redhat.com>,  Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>
> > Cc: Bj?rn T?pel <bjorn.topel@intel.com>,
> "alexander.h.duyck at intel.com" <alexander.h.duyck@intel.com>,  intel-
> wired-lan <intel-wired-lan@lists.osuosl.org>,  "netdev at vger.kernel.org"
> <netdev@vger.kernel.org>
> > Subject: Re: Issue with driver i40e stat strings count mismatch
> > Date: Tue, 31 Jul 2018 09:05:40 +0200
> > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
> >  Thunderbird/52.9.1
> > Message-ID: <64be8e6a-c285-2864-fd91-356eba645acd@kpanic.de>
> >
> > On 10.07.2018 13:17, Jesper Dangaard Brouer wrote:
> > > Hi Intel-fokes,
> > >
> > > Your i40e driver have issues with it's ethtool stats.  A warning
> > > triggers at drivers/net/ethernet/intel/i40e/i40e_ethtool.c line 1907
> > > (see splash below) in func i40e_get_stat_strings().
> >
> > Hi Jesper,
> >
> > I ran into the same issue. Here's my proposed fix.
> 
> Thanks for following up Stefan :-)
> 
> I'm hoping some Intel people will look at evaluating this fix? ...
> 
Thanks, we have a patch in process for this fix and other related ones from Jake Keller.  We'll expedite it.

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 

 
