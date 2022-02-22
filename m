From: Drewek, Wojciech <wojciech.drewek@intel.com>
Date: Tue, 22 Feb 2022 21:49:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v7 3/7] gtp: Implement GTP
 echo request
In-Reply-To: <YhVKK16JRo3THp7h@nataraja>
References: <20220221101425.19776-1-marcin.szycik@linux.intel.com>
 <20220221101425.19776-4-marcin.szycik@linux.intel.com>
 <YhSDfvQoNDyoAaV9@nataraja>
 <MW4PR11MB5776AA2256C00293FAC07C16FD3B9@MW4PR11MB5776.namprd11.prod.outlook.com>
 <YhVKK16JRo3THp7h@nataraja>
Message-ID: <MW4PR11MB57761DD076EA744C52C49FD5FD3B9@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Harald,

> -----Original Message-----
> From: Harald Welte <laforge@gnumonks.org>
> Sent: wtorek, 22 lutego 2022 21:40
> To: Drewek, Wojciech <wojciech.drewek@intel.com>
> Cc: Marcin Szycik <marcin.szycik@linux.intel.com>; netdev at vger.kernel.org; michal.swiatkowski at linux.intel.com;
> davem at davemloft.net; kuba at kernel.org; pablo at netfilter.org; jiri at resnulli.us; osmocom-net-gprs at lists.osmocom.org; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [PATCH net-next v7 3/7] gtp: Implement GTP echo request
> 
> Hi Wojciech,
> 
> On Tue, Feb 22, 2022 at 09:38:08AM +0000, Drewek, Wojciech wrote:
> 
> > > I think either the Tx and the Rx ard triggered by / notified to userspace,
> > > or you would also do periodic triggering of Tx in the kernel autonomously,
> > > and process the responses.  But at that point then you also need to think
> > > about further consequences, such as counting the number of missed ECHO RESP,
> > > and then notify userspace if that condition "N out of M last responses missed".
> > >
> >
> > I thought that with the GTP device created from ip link, userspace
> > would be unable to receive Echo Response (similar to Echo Request).
> > If it's not the case than I will get rid of handling Echo Response in the
> > next version.
> 
> Well, userspace cannot 'receive' the ECHO response through the UDP socket as
> the UDP socket is hidden in the kernel.  I was thinking of the same mechanism
> you introduce for transmit:  You can trigger the Tx of GTP ECHO REQ via netlink,
> so why shouldn't you receive a notifiation about its completion also via netlink?

How can we notify the userspace that the echo response was received? I thought
that I implemented it with the dumpit callback. Is there a way to send msg to the
userspace using generic netlink interface?
> 
> Just don't think of it as sending an ECHO REQ via netlink, but triggering the tx
> and acknowledging the completion/reception of a related response.
> 
> One of the advantages of the existing mechanism via 'socket is held in userspace'
> is that we don't have to jump through any such hoops or invent strange interfaces:
> The process can just send and receive the messages as usual via UDP socket related
> syscalls.
> 
> --
> - Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)
