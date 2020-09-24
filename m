From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 24 Sep 2020 22:25:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests: net: add a
 test for shared UDP tunnel info tables
In-Reply-To: <20200921144408.19624164@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-5-kuba@kernel.org>
 <SN6PR11MB2896F5ACC5A59F7F330183FFBC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
 <20200921144408.19624164@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <808d485e3d63a2e10f1fba75c0cac968d8f844aa.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2020-09-21 at 14:44 -0700, Jakub Kicinski wrote:
> On Sat, 19 Sep 2020 07:23:58 +0000 Brown, Aaron F wrote:
> > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> > > Behalf Of Jakub
> > > Kicinski
> > > Sent: Tuesday, July 21, 2020 6:27 PM
> > > To: davem at davemloft.net
> > > Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> > > Jakub Kicinski
> > > <kuba@kernel.org>
> > > Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests:
> > > net: add a test for
> > > shared UDP tunnel info tables
> > > 
> > > Add a test run of checks validating the shared UDP tunnel port
> > > tables function as we expect.
> > > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > >  .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 109
> > > ++++++++++++++++++
> > >  1 file changed, 109 insertions(+)
> > >   
> > 
> > I ran into two things while running this script.
> > 1. The script as it exists in the git tree (Jeff Kirshers next-
> > queue) is not executable.  I don't know if that's a patch issue or
> > translation into the tree.  Easy enough to get around, but should
> > probably be executable to start.
> 
> Ah, good catch, thanks! Please adjust in your tree or I can send a
> follow up with other patches I still have queued.

Hi Jakub,

It'd be great if you could adjust and resend the series. As we're still
working through our email server issue, I don't know if everything
would make it here.

Thanks,
Tony
