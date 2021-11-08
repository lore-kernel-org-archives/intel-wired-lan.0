From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 8 Nov 2021 09:03:02 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <YYlQfm3eW/jRS4Ra@shredder>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <YYfd7DCFFtj/x+zQ@shredder>
 <MW5PR11MB58120F585A5CF1BCA1E7E958EA919@MW5PR11MB5812.namprd11.prod.outlook.com>
 <YYlQfm3eW/jRS4Ra@shredder>
Message-ID: <20211108090302.64ca86a5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 8 Nov 2021 18:29:50 +0200 Ido Schimmel wrote:
> I also want to re-iterate my dissatisfaction with the interface being
> netdev-centric. By modelling the EEC as a standalone object we will be
> able to extend it to set the source of the EEC to something other than a
> netdev in the future. If we don't do it now, we will end up with two
> ways to report the source of the EEC (i.e., EEC_SRC_PORT and something
> else).
> 
> Other advantages of modelling the EEC as a separate object include the
> ability for user space to determine the mapping between netdevs and EECs
> (currently impossible) and reporting additional EEC attributes such as
> SyncE clockIdentity and default SSM code. There is really no reason to
> report all of this identical information via multiple netdevs.

Indeed, I feel convinced. I believe the OCP timing card will benefit
from such API as well. I pinged Jonathan if he doesn't have cycles 
I'll do the typing.

What do you have in mind for driver abstracting away pin selection?
For a standalone clock fed PPS signal from a backplate this will be
impossible, so we may need some middle way.
