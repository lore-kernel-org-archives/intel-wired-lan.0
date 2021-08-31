From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 31 Aug 2021 06:33:04 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <SJ0PR11MB4958029CF18F93846B29F685EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <SJ0PR11MB4958029CF18F93846B29F685EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
Message-ID: <20210831063304.4bcacbe3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 31 Aug 2021 10:20:18 +0000 Machnikowski, Maciej wrote:
> > Hmm, IDK if this really belongs in RTNL. The OCP time card that
> > Jonathan works on also wants to report signal lock, and it locks
> > to GNSS. It doesn't have any networking functionality whatsoever.
> > 
> > Can we add a genetlink family for clock info/configuration? From
> > what I understood discussing this with Jonathan it sounded like most
> > clocks today have a vendor-specific character device for configuration
> > and reading status.
> > 
> > I'm happy to write the plumbing if this seems like an okay idea
> > but too much work for anyone to commit.
> >   
> 
> I agree that this also is useful for Time card, yet it's also useful here.
> PTP subsystem should implement a similar logic to this one for
> DPLL-driven timers which can lock its frequency to external sources.

Why would we have two APIs for doing the same thing? IIUC Richard does
not want this in the PTP ioctls which is fair, but we need to cater to
devices which do not have netdevs.

> The reasoning behind putting it here is to enable returning the lock
> to the GNSS receiver embedded on the NIC as a source for the
> SyncE frequency. It helps distinguishing the embedded GNSS
> from the external sources. As a result - the upper layer can report
> GNSS lock based only on this message without the need to put the
> embedded  GNSS receiver in the config file. On the other hand - if
> sync to External source is reported such SW would need to read
> the source of external sync from the config file.
> 
> And the list is expandable - if we need to define more embedded
> sync source types we can always add more to it.
