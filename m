From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 4 Sep 2020 16:12:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] udp_tunnel: convert
 Intel drivers with shared tables
In-Reply-To: <20200903162220.061570d0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <1af4aea7869bdb9f3991536b6449521b214ed103.camel@intel.com>
 <bfa03cf8613ada508774a2e6e89b9b01bfd968dd.camel@intel.com>
 <20200903162220.061570d0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <072865141ce38105a12f47051585dc8deca2b3e0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2020-09-03 at 16:22 -0700, Jakub Kicinski wrote:
> On Thu, 23 Jul 2020 20:06:15 +0000 Nguyen, Anthony L wrote:
> > On Wed, 2020-07-22 at 14:22 -0700, Tony Nguyen wrote:
> > > On Tue, 2020-07-21 at 18:27 -0700, Jakub Kicinski wrote:  
> > > > This set converts Intel drivers which have the ability to spawn
> > > > multiple netdevs, but have only one UDP tunnel port table.
> > > > 
> > > > Appropriate support is added to the core infra in patch 1,
> > > > followed by netdevsim support and a selftest.
> > > > 
> > > > The table sharing works by core attaching the same table
> > > > structure to all devices sharing the table. This means the
> > > > reference count has to accommodate potentially large values.
> > > > 
> > > > Once core is ready i40e and ice are converted. These are
> > > > complex drivers, and I don't have HW to test so please
> > > > review..  
> > > 
> > > I'm requesting our developers to take a look over and validation
> > > to
> > > test the ice and i40e patches. I will report back when I get
> > > results.  
> > 
> > Would you mind if I pick these patches up into Jeff's tree? It will
> > make it easier to test that way.
> 
> It's been a month. Any ETA on these?

Sorry for taking so long. Let me check on the status and get back to
you.

Thanks,
Tony
