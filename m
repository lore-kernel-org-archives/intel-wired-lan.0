From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 23 Jul 2020 20:06:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] udp_tunnel: convert
 Intel drivers with shared tables
In-Reply-To: <1af4aea7869bdb9f3991536b6449521b214ed103.camel@intel.com>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <1af4aea7869bdb9f3991536b6449521b214ed103.camel@intel.com>
Message-ID: <bfa03cf8613ada508774a2e6e89b9b01bfd968dd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-07-22 at 14:22 -0700, Tony Nguyen wrote:
> On Tue, 2020-07-21 at 18:27 -0700, Jakub Kicinski wrote:
> > This set converts Intel drivers which have the ability to spawn
> > multiple netdevs, but have only one UDP tunnel port table.
> > 
> > Appropriate support is added to the core infra in patch 1,
> > followed by netdevsim support and a selftest.
> > 
> > The table sharing works by core attaching the same table
> > structure to all devices sharing the table. This means the
> > reference count has to accommodate potentially large values.
> > 
> > Once core is ready i40e and ice are converted. These are
> > complex drivers, and I don't have HW to test so please
> > review..
> 
> I'm requesting our developers to take a look over and validation to
> test the ice and i40e patches. I will report back when I get results.

Would you mind if I pick these patches up into Jeff's tree? It will
make it easier to test that way.

Thanks,
Tony
