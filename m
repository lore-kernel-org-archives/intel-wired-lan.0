From: Michal Kubecek <mkubecek@suse.cz>
Date: Tue, 8 Dec 2020 07:22:20 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 1/9] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <87eek11d23.fsf@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-2-vinicius.gomes@intel.com>
 <20201205094325.790b187f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <87eek11d23.fsf@intel.com>
Message-ID: <20201208062220.3xrhdo47lgpyttfi@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 07, 2020 at 02:11:48PM -0800, Vinicius Costa Gomes wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> >> + * @min_frag_size_mult: Minimum size for all non-final fragment size,
> >> + * expressed in terms of X in '(1 + X)*64 + 4'
> >
> > Is this way of expressing the min frag size from the standard?
> >
> 
> The standard has this: "A 2-bit integer value indicating, in units of 64
> octets, the minimum number of octets over 64 octets required in
> non-final fragments by the receiver" from IEEE 802.3br-2016, Table
> 79-7a.

Can we be sure that newer version of the standard cannot change this,
e.g. come with a finer granularity? Perhaps it would be safer to express
the size in bytes in the userspace API and translate to this internal
representation in common ethtool code.

Also, please don't forget to update Documentation/networking/ethtool-netlink.rst

Michal
