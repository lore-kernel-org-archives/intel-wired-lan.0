From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 6 May 2022 09:13:22 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] drivers,
 ixgbe: show VF statistics
In-Reply-To: <20220506064440.57940-1-mheyne@amazon.de>
References: <20220504201632.2a41a3b9@kernel.org>
 <20220506064440.57940-1-mheyne@amazon.de>
Message-ID: <20220506091322.1be7ee6e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 6 May 2022 06:44:40 +0000 Maximilian Heyne wrote:
> On 2022-05-04T20:16:32-07:00   Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 3 May 2022 15:00:17 +0000 Maximilian Heyne wrote:  
> > > +		for (i = 0; i < adapter->num_vfs; i++) {
> > > +			ethtool_sprintf(&p, "VF %u Rx Packets", i);
> > > +			ethtool_sprintf(&p, "VF %u Rx Bytes", i);
> > > +			ethtool_sprintf(&p, "VF %u Tx Packets", i);
> > > +			ethtool_sprintf(&p, "VF %u Tx Bytes", i);
> > > +			ethtool_sprintf(&p, "VF %u MC Packets", i);
> > > +		}  
> > 
> > Please drop the ethtool stats. We've been trying to avoid duplicating
> > the same stats in ethtool and iproute2 for a while now.
> 
> I can see the point that standard metrics should only be reported via the
> iproute2 interface. However, in this special case this patch was
> intended to converge the out-of-tree driver with the in-tree version.
> These missing stats were breaking our userspace. If we now switch
> solely to iproute2 based statistics both driver versions would
> diverge even more. So depending on where a user gets the ixgbe driver
> from, they have to work-around.
> 
> I can change the patch as requested, but it will contradict the inital
> intention. At least Intel should then port this change to the
> external driver as well. Let's get a statement from them.

Ack, but we really want people to move towards using standard stats.

Can you change the user space to first try reading the stats via
iproute2/rtnetlink? And fallback to random ethtool strings if not
available? That way it will work with any driver implementing the
standard API. Long term that'll make everyone's life easier.

Out-of-tree code cannot be an argument upstream, otherwise we'd
completely lose control over our APIs. Vendors could ship whatever
in their out of tree repo and then force us to accept it upstream.

It's disappointing to see the vendor letting the uAPI of the out of
tree driver diverge from upstream, especially a driver this mature.
